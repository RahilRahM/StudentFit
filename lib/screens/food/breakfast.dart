import 'commons.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  // List of image data (path and title)
  final List<Map<String, String>> imageData = [
    {
      'path': 'assets/images/recipe1.jpeg',
      'title': 'Banana Berry Acai Bowl',
      'ingredients': '''
          Banana
          Mixed Berries
          Acai Puree
          Greek Yogurt 
          Honey
          ''',
      'recipe': '''
        1. Blend all ingredients until smooth.
        2. Pour into a bowl.
        3. Add toppings of your choice.
      ''',
    },
    {
      'path': 'assets/images/recipe2.jpeg',
      'title': 'Smoothie Bowl',
      'ingredients': '''
        Your choice of fruits
        Greek Yogurt
        Honey
        Granola
          ''',
      'recipe': '''
        1. Blend fruits, Greek Yogurt, and Honey until smooth.
        2. Pour into a bowl.
        3. Sprinkle with granola.
      ''',
    },
    {
      'path': 'assets/images/recipe3.jpeg',
      'title': 'Avocado toast with tomato',
      'ingredients': '''
      Avocado
       Bread 
       Tomato
       Salt
       Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Add sliced tomato.
        4. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Cilantro Lime Avocado Toast',
      'ingredients': '''
       Avocado
        Bread
         Lime 
         juice
          Cilantro
           Salt 
           Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Squeeze lime juice over the avocado.
        4. Sprinkle with chopped cilantro.
        5. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe5.jpeg',
      'title': 'Chocolate Chip Banana Pancakes',
      'ingredients': '''
Banana 
Pancake
 mix 
 Chocolate 
 chips 
 Milk ''',
      'recipe': '''
        1. Mash banana and mix with pancake mix and milk.
        2. Stir in chocolate chips.
        3. Cook pancakes on a hot griddle.
      ''',
    },
    {
      'path': 'assets/images/recipe6.jpeg',
      'title': 'Fruit Salad',
      'ingredients': '''
       Assorted
        fruits 
        (e.g., apples, oranges, grapes)
        ''',
      'recipe': '''
        1. Wash and chop fruits into bite-sized pieces.
        2. Combine in a bowl.
        3. Serve chilled.
      ''',
    },
    {
      'path': 'assets/images/recipe7.jpeg',
      'title': 'Egg Breakfast Bowl',
      'ingredients': '''
Eggs
Spinach 
Tomato
 Cheese 
 Salt 
 Pepper
''',
      'recipe': '''
        1. Scramble eggs and cook with spinach, tomatoes, and cheese.
        2. Season with salt and pepper.
        3. Serve hot in a bowl.
      ''',
    },
    {
      'path': 'assets/images/recipe9.jpeg',
      'title': 'Yogurt Parfait',
      'ingredients': '''
      Greek yogurt
       Granola
        Mixed berries
         Honey
      ''',
      'recipe': '''
        1. Layer Greek yogurt, granola, and mixed berries in a glass.
        2. Drizzle with honey.
        3. Repeat the layers.
      ''',
    },
    {
      'path': 'assets/images/recipe1.jpeg',
      'title': 'Banana Berry Acai Bowl',
      'ingredients': '''
          Banana
          Mixed Berries
          Acai Puree
          Greek Yogurt 
          Honey
          ''',
      'recipe': '''
        1. Blend all ingredients until smooth.
        2. Pour into a bowl.
        3. Add toppings of your choice.
      ''',
    },
    {
      'path': 'assets/images/recipe2.jpeg',
      'title': 'Smoothie Bowl',
      'ingredients': '''
        Your choice of fruits
        Greek Yogurt
        Honey
        Granola
          ''',
      'recipe': '''
        1. Blend fruits, Greek Yogurt, and Honey until smooth.
        2. Pour into a bowl.
        3. Sprinkle with granola.
      ''',
    },
    {
      'path': 'assets/images/recipe3.jpeg',
      'title': 'Avocado toast with tomato',
      'ingredients': '''
      Avocado
       Bread 
       Tomato
       Salt
       Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Add sliced tomato.
        4. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Cilantro Lime Avocado Toast',
      'ingredients': '''
       Avocado
        Bread
         Lime 
         juice
          Cilantro
           Salt 
           Pepper
      ''',
      'recipe': '''
        1. Toast the bread.
        2. Mash avocado and spread on the toast.
        3. Squeeze lime juice over the avocado.
        4. Sprinkle with chopped cilantro.
        5. Season with salt and pepper.
      ''',
    },
    {
      'path': 'assets/images/recipe5.jpeg',
      'title': 'Chocolate Chip Banana Pancakes',
      'ingredients': '''
Banana 
Pancake
 mix 
 Chocolate 
 chips 
 Milk ''',
      'recipe': '''
        1. Mash banana and mix with pancake mix and milk.
        2. Stir in chocolate chips.
        3. Cook pancakes on a hot griddle.
      ''',
    },
    {
      'path': 'assets/images/recipe6.jpeg',
      'title': 'Fruit Salad',
      'ingredients': '''
       Assorted
        fruits 
        (e.g., apples, oranges, grapes)
        ''',
      'recipe': '''
        1. Wash and chop fruits into bite-sized pieces.
        2. Combine in a bowl.
        3. Serve chilled.
      ''',
    },
    {
      'path': 'assets/images/recipe7.jpeg',
      'title': 'Egg Breakfast Bowl',
      'ingredients': '''
Eggs
Spinach 
Tomato
 Cheese 
 Salt 
 Pepper
''',
      'recipe': '''
        1. Scramble eggs and cook with spinach, tomatoes, and cheese.
        2. Season with salt and pepper.
        3. Serve hot in a bowl.
      ''',
    },
    {
      'path': 'assets/images/recipe9.jpeg',
      'title': 'Yogurt Parfait',
      'ingredients': '''
      Greek yogurt
       Granola
        Mixed berries
         Honey
      ''',
      'recipe': '''
        1. Layer Greek yogurt, granola, and mixed berries in a glass.
        2. Drizzle with honey.
        3. Repeat the layers.
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
    final favoriteImagesList = _prefs?.getStringList('breakfastFavoriteImages') ?? [];
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
    await _prefs?.setStringList('breakfastFavoriteImages', favoriteImages);
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


  //card images
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
                  SizedBox(height: 1.0),
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
