import 'commons.dart';
import './breakfast.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DinnerPage extends StatefulWidget {
  @override
  _DinnerPageState createState() => _DinnerPageState();
}

class _DinnerPageState extends State<DinnerPage> {

  // List of image data (path and title)
  final List<Map<String, String>> imageData= [
    {
      'path': 'assets/images/TeriyakiSalmonSushiBowl.jpg',
      'title': 'Teriyaki Salmon Sushi Bowl',
      'ingredients': '''
        Salmon
        Sushi Rice
        Teriyaki Sauce
        Avocado
        Cucumber
      ''',
      'recipe': '''
        1. Cook salmon and glaze with teriyaki sauce.
        2. Prepare sushi rice.
        3. Assemble the bowl with rice, salmon, avocado, and cucumber.
      ''',
    },
    {
      'path': 'assets/images/lunch7.jpeg',
      'title': 'Healthy Pasta',
      'ingredients': '''
        Whole Wheat Pasta
        Broccoli
        Cherry Tomatoes
        Olive Oil
        Garlic
      ''',
      'recipe': '''
        1. Cook whole wheat pasta.
        2. Sauté broccoli, cherry tomatoes, and garlic in olive oil.
        3. Toss with cooked pasta.
      ''',
    },
    {
      'path': 'assets/images/lunch8.png',
      'title': 'Spaghetti',
      'ingredients': '''
        Spaghetti
        Tomato Sauce
        Ground Beef (optional)
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Cook spaghetti.
        2. If desired, brown ground beef and mix with tomato sauce.
        3. Serve spaghetti with sauce and Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/lunch1.png',
      'title': 'Bean Salad',
      'ingredients': '''
        Canned Beans
        Cherry Tomatoes
        Red Onion
        Olive Oil
        Balsamic Vinegar
      ''',
      'recipe': '''
        1. Mix canned beans, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and balsamic vinegar.
        3. Toss well and serve.
      ''',
    },
    {
      'path': 'assets/images/lunch2.jpeg',
      'title': 'Mediterranean Tuna Salad',
      'ingredients': '''
        Tuna
        Cucumber
        Cherry Tomatoes
        Red Onion
        Olive Oil
      ''',
      'recipe': '''
        1. Combine tuna, cucumber, cherry tomatoes, and red onion in a bowl.
        2. Drizzle with olive oil and toss to combine.
        3. Serve as a refreshing salad.
      ''',
    },
    {
      'path': 'assets/images/LoadedSpicyShrimpBowl.jpg',
      'title': 'Loaded Spicy Shrimp Bowl',
      'ingredients': '''
        Shrimp
        Rice
        Spices
        Black Beans
        Corn
      ''',
      'recipe': '''
        1. Season and cook shrimp with spices.
        2. Cook rice and top with black beans and corn.
        3. Add spicy shrimp on top.
      ''',
    },
    {
      'path': 'assets/images/zucchinislice.jpg',
      'title': 'Zucchini Slice',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Cheese
        Bacon
      ''',
      'recipe': '''
        1. Grate zucchini and mix with eggs, flour, cheese, and bacon.
        2. Bake until golden brown.
      ''',
    },
    {
      'path': 'assets/images/besteasypumpkinsouprecipe.jpeg',
      'title': 'Best Easy Pumpkin Soup Recipe',
      'ingredients': '''
        Pumpkin
        Onion
        Garlic
        Vegetable Broth
        Cream
      ''',
      'recipe': '''
        1. Sauté onion and garlic, then add pumpkin and vegetable broth.
        2. Simmer until pumpkin is tender, then blend.
        3. Stir in cream and serve.
      ''',
    },
    {
      'path': 'assets/images/easyfriedrice.jpeg',
      'title': 'Easy Fried Rice',
      'ingredients': '''
        Rice
        Vegetables
        Soy Sauce
        Eggs
        Sesame Oil
      ''',
      'recipe': '''
        1. Cook rice and set aside.
        2. Sauté vegetables, add eggs, then mix in rice and soy sauce.
        3. Drizzle with sesame oil and serve.
      ''',
    },
    {
      'path': 'assets/images/classicshepherdspie.jpg',
      'title': 'Classic Shepherd Pie',
      'ingredients': '''
        Ground Beef
        Vegetables
        Mashed Potatoes
        Gravy
      ''',
      'recipe': '''
        1. Brown ground beef, add vegetables, and top with mashed potatoes.
        2. Bake until golden and serve with gravy.
      ''',
    },
    {
      'path': 'assets/images/quiche.jpeg',
      'title': 'Quiche',
      'ingredients': '''
        Pie Crust
        Eggs
        Milk
        Cheese
        Vegetables
      ''',
      'recipe': '''
        1. Line pie crust with vegetables and cheese.
        2. Whisk eggs and milk, then pour into crust.
        3. Bake until set and golden.
      ''',
    },
    {
      'path': 'assets/images/basicchickenandvegetablestirfry.jpeg',
      'title': 'Basic Chicken and Vegetable Stir Fry',
      'ingredients': '''
        Chicken
        Vegetables
        Soy Sauce
        Ginger
        Garlic
      ''',
      'recipe': '''
        1. Stir fry chicken and vegetables with ginger and garlic.
        2. Add soy sauce for flavor.
        3. Serve over rice or noodles.
      ''',
    },
    {
      'path': 'assets/images/easybutterchicken.jpg',
      'title': 'Easy Butter Chicken',
      'ingredients': '''
        Chicken
        Butter
        Tomatoes
        Cream
        Spices
      ''',
      'recipe': '''
        1. Sauté chicken in butter, add tomatoes, cream, and spices.
        2. Simmer until the sauce thickens and serve.
      ''',
    },
    {
      'path': 'assets/images/spaghettibolognese.jpeg',
      'title': 'Spaghetti Bolognese',
      'ingredients': '''
        Ground Beef
        Tomatoes
        Onion
        Spaghetti
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Brown ground beef and onion, add tomatoes, and simmer.
        2. Serve over cooked spaghetti with Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/zucchinifritters.jpeg',
      'title': 'Zucchini Fritters',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Feta Cheese
        Dill
      ''',
      'recipe': '''
        1. Grate zucchini, mix with eggs, flour, feta cheese, and dill.
        2. Fry until golden brown and serve.
      ''',
    },
 
    {
      'path': 'assets/images/TeriyakiSalmonSushiBowl.jpg',
      'title': 'Teriyaki Salmon Sushi Bowl',
      'ingredients': '''
        Salmon
        Sushi Rice
        Teriyaki Sauce
        Avocado
        Cucumber
      ''',
      'recipe': '''
        1. Cook salmon and glaze with teriyaki sauce.
        2. Prepare sushi rice.
        3. Assemble the bowl with rice, salmon, avocado, and cucumber.
      ''',
    },
    {
      'path': 'assets/images/LoadedSpicyShrimpBowl.jpg',
      'title': 'Loaded Spicy Shrimp Bowl',
      'ingredients': '''
        Shrimp
        Rice
        Spices
        Black Beans
        Corn
      ''',
      'recipe': '''
        1. Season and cook shrimp with spices.
        2. Cook rice and top with black beans and corn.
        3. Add spicy shrimp on top.
      ''',
    },
    {
      'path': 'assets/images/zucchinislice.jpg',
      'title': 'Zucchini Slice',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Cheese
        Bacon
      ''',
      'recipe': '''
        1. Grate zucchini and mix with eggs, flour, cheese, and bacon.
        2. Bake until golden brown.
      ''',
    },
    {
      'path': 'assets/images/besteasypumpkinsouprecipe.jpeg',
      'title': 'Best Easy Pumpkin Soup Recipe',
      'ingredients': '''
        Pumpkin
        Onion
        Garlic
        Vegetable Broth
        Cream
      ''',
      'recipe': '''
        1. Sauté onion and garlic, then add pumpkin and vegetable broth.
        2. Simmer until pumpkin is tender, then blend.
        3. Stir in cream and serve.
      ''',
    },
    {
      'path': 'assets/images/easyfriedrice.jpeg',
      'title': 'Easy Fried Rice',
      'ingredients': '''
        Rice
        Vegetables
        Soy Sauce
        Eggs
        Sesame Oil
      ''',
      'recipe': '''
        1. Cook rice and set aside.
        2. Sauté vegetables, add eggs, then mix in rice and soy sauce.
        3. Drizzle with sesame oil and serve.
      ''',
    },
    {
      'path': 'assets/images/classicshepherdspie.jpg',
      'title': 'Classic Shepherd Pie',
      'ingredients': '''
        Ground Beef
        Vegetables
        Mashed Potatoes
        Gravy
      ''',
      'recipe': '''
        1. Brown ground beef, add vegetables, and top with mashed potatoes.
        2. Bake until golden and serve with gravy.
      ''',
    },
    {
      'path': 'assets/images/quiche.jpeg',
      'title': 'Quiche',
      'ingredients': '''
        Pie Crust
        Eggs
        Milk
        Cheese
        Vegetables
      ''',
      'recipe': '''
        1. Line pie crust with vegetables and cheese.
        2. Whisk eggs and milk, then pour into crust.
        3. Bake until set and golden.
      ''',
    },
    {
      'path': 'assets/images/basicchickenandvegetablestirfry.jpeg',
      'title': 'Basic Chicken and Vegetable Stir Fry',
      'ingredients': '''
        Chicken
        Vegetables
        Soy Sauce
        Ginger
        Garlic
      ''',
      'recipe': '''
        1. Stir fry chicken and vegetables with ginger and garlic.
        2. Add soy sauce for flavor.
        3. Serve over rice or noodles.
      ''',
    },
    {
      'path': 'assets/images/easybutterchicken.jpg',
      'title': 'Easy Butter Chicken',
      'ingredients': '''
        Chicken
        Butter
        Tomatoes
        Cream
        Spices
      ''',
      'recipe': '''
        1. Sauté chicken in butter, add tomatoes, cream, and spices.
        2. Simmer until the sauce thickens and serve.
      ''',
    },
    {
      'path': 'assets/images/spaghettibolognese.jpeg',
      'title': 'Spaghetti Bolognese',
      'ingredients': '''
        Ground Beef
        Tomatoes
        Onion
        Spaghetti
        Parmesan Cheese
      ''',
      'recipe': '''
        1. Brown ground beef and onion, add tomatoes, and simmer.
        2. Serve over cooked spaghetti with Parmesan cheese.
      ''',
    },
    {
      'path': 'assets/images/zucchinifritters.jpeg',
      'title': 'Zucchini Fritters',
      'ingredients': '''
        Zucchini
        Eggs
        Flour
        Feta Cheese
        Dill
      ''',
      'recipe': '''
        1. Grate zucchini, mix with eggs, flour, feta cheese, and dill.
        2. Fry until golden brown and serve.
      ''',
    },
   
   
  ];
  

  SharedPreferences? _prefs;
  //imageData.shuffle();
  @override
  void initState() {
    super.initState();
    filteredImageData = List.from(imageData);
    _loadFavoriteImages();
  }

  Future<void> _loadFavoriteImages() async {
    _prefs = await SharedPreferences.getInstance();
    final favoriteImagesList = _prefs?.getStringList('dinnerFavoriteImages') ?? [];
    setState(() {
      favoriteImages = favoriteImagesList;
    });
  }
  // List to store the favorite images
  List<String> favoriteImages = [];
  List<String> favoriteRecipes = [];

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

  void toggleFavorite(String imagePath) async {
    setState(() {
      if (favoriteImages.contains(imagePath)) {
        favoriteImages.remove(imagePath);
      } else {
        favoriteImages.add(imagePath);
      }
    });

    // Save the updated list of favorite images to SharedPreferences
    await _prefs?.setStringList('dinnerFavoriteImages', favoriteImages);
  }


  //search
  void updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredImageData = List.from(imageData);
      } else {
        filteredImageData = imageData
            .where((data) =>
                data['title']!.toLowerCase().startsWith(query.toLowerCase()))
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
  //image card
  Widget buildCard(String imagePath, String title, bool isFavorite,
      Function() onFavoritePressed) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: 175.0,
      height: 175.0,
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onTap: () {
                int index = filteredImageData
                    .indexWhere((data) => data['path'] == imagePath);
                navigateToDetailPage(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -4.0,
            right: 15.0,
            child: FavoriteButton(
              onFavoriteChanged: (bool isFavorite) {
                onFavoritePressed();
              },
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
        padding: const EdgeInsets.all(0.0),
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
                          onChanged: (query) => updateSearch(query),
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
                      final data = filteredImageData[index];
                      final imagePath = data['path']!;
                      final title = data['title']!;
                      final isFavorite = favoriteImages.contains(imagePath);

                      return buildCard(imagePath, title, isFavorite, () {
                        toggleFavorite(imagePath);
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
