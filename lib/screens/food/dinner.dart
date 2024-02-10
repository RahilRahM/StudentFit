import 'dart:convert';
import 'commons.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:StudentFit/screens/food/breakfast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DinnerPage extends StatefulWidget {
  @override
  _DinnerPageState createState() => _DinnerPageState();
}

class _DinnerPageState extends State<DinnerPage> {
  bool _isWidgetMounted = true;
  SharedPreferences? _prefs;
  List<String> favoriteImages = [];
  List<Map<String, String>> imageData = [];
  List<Map<String, dynamic>> filteredImageData = [];
  TextEditingController searchController = TextEditingController();
  List<String> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredImageData = List.from(imageData);
    _isWidgetMounted = true;
    _loadFavoriteImages();
    _fetchSnacks();
  }

  @override
  void dispose() {
    _isWidgetMounted = false;
    super.dispose();
  }

  void toggleFavorite(String imagePath) {
    setState(() {
      if (favoriteImages.contains(imagePath)) {
        favoriteImages.remove(imagePath);
      } else {
        favoriteImages.add(imagePath);
      }
      _prefs?.setStringList('dinnerFavoriteImages', favoriteImages);
    });
  }

  Future<void> _loadFavoriteImages() async {
    _prefs = await SharedPreferences.getInstance();
    final favoriteImagesList =
        _prefs?.getStringList('dinnerFavoriteImages') ?? [];
    setState(() {
      favoriteImages = favoriteImagesList;
    });
  }

  Future<void> _loadFavoriteRecipes() async {
    favoriteRecipes = await FavoriteRecipes.getFavoriteRecipes();
    setState(() {
      filteredImageData = List.from(imageData);
    });
  }

  void _saveFavoriteRecipes() async {
    await FavoriteRecipes.saveFavoriteRecipes(favoriteRecipes);
  }

  Future<void> _fetchSnacks() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('dinner');
      final listResult = await storageRef.listAll();

      List<Future> futures = [];

      for (var item in listResult.items) {
        futures.add(_fetchAndAddSnackData(item));
      }

      await Future.wait(futures);

      if (_isWidgetMounted) {
        setState(() {
          filteredImageData = List.from(imageData);
        });
      }
    } catch (e) {
      print("Error fetching dinner: $e");
     
    }
  }

  Future<void> _fetchAndAddSnackData(Reference item) async {
    final url = await item.getDownloadURL();
    final path = item.fullPath;
    final response = await http.get(
      Uri.parse('https://studentfit-api.vercel.app/getRecipes?image_id=$path'),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      final recipeDetails = jsonDecode(response.body)['recipe'];
      if (!mounted) return;
      setState(() {
        imageData.add({
          'path': url, 
          'title': recipeDetails['title'],
          'ingredients': recipeDetails['ingredients'],
          'instructions': recipeDetails['instructions'],
        });

        filteredImageData = List.from(imageData);
      });
    } else {
      print("Failed to fetch recipe data: ${response.body}");
    }
  }

  void updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredImageData = List.from(imageData);
      } else {
        filteredImageData = imageData
            .where((data) =>
                data['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
  

  //navigation
  void navigateToDetailPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RecipeDetailPage(recipeData: filteredImageData[index]),
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> recipeData, bool isFavorite,
      Function() onFavoritePressed) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: 175.0,
      height: 1750.0,
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetailPage(recipeData: recipeData),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        recipeData['path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recipeData['title'],
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5.0,
            right: 5.0,
            child: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: isFavorite ? Colors.red : Colors.grey,
              onPressed: onFavoritePressed,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Dinner',
        showFavoriteIcon: true,
        onFavoritePressed: () {
          if (favoriteImages.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(favoriteImages, imageData),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => buildEmptyFavoritesDialog(context),
            );
          }
        },
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      backgroundColor: Colors.white,
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth = constraints.maxWidth / 2 - 10;
            double searchBarWidth =
                constraints.maxWidth > 400 ? 400 : constraints.maxWidth - 16;
            return Column(
              children: [
                Container(
                  width: searchBarWidth,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: const Color.fromARGB(255, 236, 238, 241),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF9FA5C0),
                          size: 28.006,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: updateSearch,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.50),
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.105,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: cardWidth / (cardWidth + 80),
                    ),
                    itemCount: filteredImageData.length,
                    itemBuilder: (context, index) {
                      final recipeData = filteredImageData[index];
                      final isFavorite =
                          favoriteImages.contains(recipeData['path']);
                      return buildCard(recipeData, isFavorite, () {
                        toggleFavorite(recipeData['path']!);
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
