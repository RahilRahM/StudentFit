import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:StudentFit/screens/food/recipe_detail_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CaloriesDetailPage extends StatelessWidget {
  CaloriesDetailPage({Key? key, required Map<String, String> recipeData}) : super(key: key);

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<String> getRandomImagePath(String mealType) async {
    final firebase_storage.ListResult result = await storage.ref(mealType).listAll();
    final List<firebase_storage.Reference> allFiles = result.items;
    // Ensure you have at least one file in 'allFiles', otherwise this will throw an error.
    final firebase_storage.Reference randomFile = allFiles[Random().nextInt(allFiles.length)];
    return await randomFile.getDownloadURL();
  }

  Future<Map<String, dynamic>> getSavedMenuOrGenerateNew(String mealType) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now();
    final savedMenuString = prefs.getString('$mealType-savedMenu');
    final savedMenu = savedMenuString != null ? json.decode(savedMenuString) as Map<String, dynamic> : null;
    final savedTimestamp = prefs.getString('$mealType-savedMenuTimestamp');

    // If there's a saved menu and the saved timestamp is less than 24 hours ago, use it
    if (savedMenu != null && savedTimestamp != null && DateTime.parse(savedTimestamp).add(Duration(days: 1)).isAfter(currentTime)) {
      return savedMenu;
    } else {
      // Otherwise, generate a new menu
      final newMenu = await generateNewMenu(mealType);

      // Save the new menu and the current timestamp
      await prefs.setString('$mealType-savedMenu', json.encode(newMenu));
      await prefs.setString('$mealType-savedMenuTimestamp', currentTime.toIso8601String());

      return newMenu;
    }
  }

  Future<Map<String, dynamic>> generateNewMenu(String mealType) async {
    final imagePath = await getRandomImagePath(mealType);
    
    // Generate your menu details here. For now, let's assume you just return the image path.
    final menuData = {
      'path': imagePath,
      'title': mealType[0].toUpperCase() + mealType.substring(1),
      // Add additional details as required
    };
    
    return menuData;
  }
  

  @override
  Widget build(BuildContext context) {
    List<String> mealTypes = ['breakfast', 'lunch', 'snack', 'dinner'];
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Suggested Menu',
        showFavoriteIcon: false,
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () => Navigator.pop(context),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: mealTypes.map((mealType) {
            return FutureBuilder(
              future: getRandomImagePath('$mealType/'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return MenuWidget(
                    recipeData: {
                      'path': snapshot.data!,
                      'title': mealType[0].toUpperCase() + mealType.substring(1),
                      'energy': '??k',
                      'protein': '??g',
                      'carbs': '??g',
                      'fat': '??g',
                    },
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return SizedBox();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  final Map<String, dynamic> recipeData;

  const MenuWidget({required this.recipeData, Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(recipeData: widget.recipeData),
          ),
        );
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // add perspective
          ..rotateY(_isTapped ? -0.05 : 0), // subtle tilt when tapped
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    widget.recipeData['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Image.network(
                widget.recipeData['path'] ?? '',
                fit: BoxFit.cover,
                height: 150.0,
                width: double.infinity,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
