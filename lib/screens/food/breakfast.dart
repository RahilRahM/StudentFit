import 'recipe_detail_page.dart'; 
import 'package:flutter/material.dart';
import 'package:StudentFit/screens/food/commons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:StudentFit/screens/food/favorite_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:StudentFit/screens/home/home_widgets/app_bar.dart';
import 'package:StudentFit/screens/home/home_widgets/side_bar.dart';

class FavoriteRecipes {
  static Future<List<String>> getFavoriteRecipes() async {
    
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];
    return favoriteRecipes;
  }

  static Future<void> saveFavoriteRecipes(List<String> favoriteRecipes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteRecipes', favoriteRecipes);
  }
}

class BreakfastPage extends StatefulWidget {
  @override
  _BreakfastPageState createState() => _BreakfastPageState();
}

class _BreakfastPageState extends State<BreakfastPage> {
  List<Map<String,  String>> imageData = [];
  SharedPreferences? _prefs;
  List<String> favoriteImages = [];
  List<String> favoriteRecipes = [];


  @override
  void initState() {
    super.initState();
    filteredImageData = List.from(imageData);
    _loadImages();
    _loadFavoriteImages();
 

  }

  Future<void> _loadFavoriteImages() async {
    _prefs = await SharedPreferences.getInstance();
    final favoriteImagesList = _prefs?.getStringList('breakfastFavoriteImages') ?? [];
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


  List<Map<String, String>> filteredImageData = [];
  TextEditingController searchController = TextEditingController();

  Future<void> _loadImages() async {
    final storageRef = FirebaseStorage.instance.ref().child('breakfast');
    final listResult = await storageRef.listAll();

    for (var item in listResult.items) {
      final url = await item.getDownloadURL();
      final metadata = await item.getMetadata();
      imageData.add({
        'path': url,
        'title': metadata.customMetadata?['title'] ?? 'Recipe Title',
        'ingredients': metadata.customMetadata?['ingredients'] ?? 'Ingredients not available',
        'recipe': metadata.customMetadata?['recipe'] ?? 'Recipe instructions not available',
      });
    }
    setState(() {});
  }

  


  void toggleFavorite(String imagePath) async {
    setState(() {
      if (favoriteImages.contains(imagePath)) {
        favoriteImages.remove(imagePath);
      } else {
        favoriteImages.add(imagePath);
      }
    });
    await _prefs?.setStringList('breakfastFavoriteImages', favoriteImages);
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

  Widget buildCard(Map<String, dynamic> recipeData, bool isFavorite, Function() onFavoritePressed) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: 175.0,
      height: 1750.0, // Adjusted height to fit more content
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
                    builder: (context) => RecipeDetailPage(recipeData: recipeData),
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
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
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
        appBarTitle: 'Breakfast',
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: cardWidth / (cardWidth + 80),
              ),
        itemCount: imageData.length,
        itemBuilder: (context, index) {
          final recipeData = imageData[index];
          final isFavorite = favoriteImages.contains(recipeData['path']);
          return buildCard(recipeData, isFavorite, () {
            toggleFavorite(recipeData['path']!);
          });
        },
      );
    }
    ),
  ),
    );
  }
}
