import 'commons.dart';
import './breakfast.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LunchPage extends StatefulWidget {
  @override
  _LunchPageState createState() => _LunchPageState();
}

class _LunchPageState extends State<LunchPage> {
  // List of image data (path and title)
  final List<Map<String, String>> imageData = [
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
      'path': 'assets/images/lunch3.png',
      'title': 'Ramen',
      'ingredients': '''
        Ramen Noodles
        Broth
        Vegetables (e.g., Bok Choy, Mushrooms)
        Soy Sauce
      ''',
      'recipe': '''
        1. Cook ramen noodles according to package instructions.
        2. Heat broth and add vegetables.
        3. Add cooked ramen noodles and soy sauce.
        4. Serve hot.
      ''',
    },
    {
      'path': 'assets/images/lunch4.jpeg',
      'title': 'Cumin-Roasted Carrot & Cauliflower',
      'ingredients': '''
        Carrots
        Cauliflower
        Cumin
        Olive Oil
        Salt and Pepper
      ''',
      'recipe': '''
        1. Toss carrots and cauliflower with cumin, olive oil, salt, and pepper.
        2. Roast in the oven until tender.
        3. Serve as a side dish.
      ''',
    },
    {
      'path': 'assets/images/lunch5.jpeg',
      'title': 'Amatriciana',
      'ingredients': '''
        Pasta
        Pancetta or Guanciale
        Tomatoes
        Onion
        Pecorino Cheese
      ''',
      'recipe': '''
        1. Cook pasta until al dente.
        2. Sauté pancetta or guanciale and onion in a pan.
        3. Add tomatoes and simmer.
        4. Toss pasta with the sauce and top with Pecorino cheese.
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
      'path': 'assets/images/lunch6.jpeg',
      'title': 'Sautéed Shrimp',
      'ingredients': '''
        Shrimp
        Garlic
        Butter
        Lemon Juice
        Parsley
      ''',
      'recipe': '''
        1. Sauté shrimp and garlic in butter.
        2. Add lemon juice and parsley.
        3. Cook until shrimp turn pink.
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
      'path': 'assets/images/lunch3.png',
      'title': 'Ramen',
      'ingredients': '''
        Ramen Noodles
        Broth
        Vegetables (e.g., Bok Choy, Mushrooms)
        Soy Sauce
      ''',
      'recipe': '''
        1. Cook ramen noodles according to package instructions.
        2. Heat broth and add vegetables.
        3. Add cooked ramen noodles and soy sauce.
        4. Serve hot.
      ''',
    },
    {
      'path': 'assets/images/lunch4.jpeg',
      'title': 'Cumin-Roasted Carrot & Cauliflower',
      'ingredients': '''
        Carrots
        Cauliflower
        Cumin
        Olive Oil
        Salt and Pepper
      ''',
      'recipe': '''
        1. Toss carrots and cauliflower with cumin, olive oil, salt, and pepper.
        2. Roast in the oven until tender.
        3. Serve as a side dish.
      ''',
    },
    {
      'path': 'assets/images/lunch5.jpeg',
      'title': 'Amatriciana',
      'ingredients': '''
        Pasta
        Pancetta or Guanciale
        Tomatoes
        Onion
        Pecorino Cheese
      ''',
      'recipe': '''
        1. Cook pasta until al dente.
        2. Sauté pancetta or guanciale and onion in a pan.
        3. Add tomatoes and simmer.
        4. Toss pasta with the sauce and top with Pecorino cheese.
      ''',
    },
    {
      'path': 'assets/images/lunch6.jpeg',
      'title': 'Sautéed Shrimp',
      'ingredients': '''
        Shrimp
        Garlic
        Butter
        Lemon Juice
        Parsley
      ''',
      'recipe': '''
        1. Sauté shrimp and garlic in butter.
        2. Add lemon juice and parsley.
        3. Cook until shrimp turn pink.
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
    final favoriteImagesList = _prefs?.getStringList('lunchFavoriteImages') ?? [];
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
    await _prefs?.setStringList('lunchFavoriteImages', favoriteImages);
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
        // ignore: unused_local_variable
        final isFavorite = favoriteImages.contains(imagePath);
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
           
              onFavoriteChanged: (bool isCurrentlyFavorite) {
                toggleFavorite(imagePath);
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
        appBarTitle: 'Lunch',
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
