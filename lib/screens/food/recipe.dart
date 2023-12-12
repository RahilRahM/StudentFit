import 'commons.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  // List of image data (path and title)
  final List<Map<String, String>> imageData = [
    {'path': 'assets/images/snack1.jpeg', 'title': 'Frozen Vanilla berry bark'},
    {'path': 'assets/images/snack2.jpeg', 'title': 'Energy bar'},
    {'path': 'assets/images/snack3.jpeg', 'title': 'Apple peanut butter'},
    {'path': 'assets/images/snack4.jpeg', 'title': 'Frozen Yogurt'},
    {'path': 'assets/images/snack5.png', 'title': 'Healthy cookies'},
    {'path': 'assets/images/snack6.jpeg', 'title': 'Healthy smoothies'},
    {'path': 'assets/images/snack7.jpeg', 'title': 'Fruits'},
    {'path': 'assets/images/snack8.jpeg', 'title': 'Greek yogurt brownies'},
    {'path': 'assets/images/snack1.jpeg', 'title': 'Frozen Vanilla berry bark'},
    {'path': 'assets/images/snack2.jpeg', 'title': 'Energy bar'},
    {'path': 'assets/images/snack3.jpeg', 'title': 'Apple peanut butter'},
    {'path': 'assets/images/snack4.jpeg', 'title': 'Frozen Yogurt'},
    {'path': 'assets/images/snack5.png', 'title': 'Healthy cookies'},
    {'path': 'assets/images/snack6.jpeg', 'title': 'Healthy smoothies'},
    {'path': 'assets/images/snack7.jpeg', 'title': 'Fruits'},
    {'path': 'assets/images/snack8.jpeg', 'title': 'Greek yogurt brownies'},
    {'path': 'assets/images/lunch1.png', 'title': 'Bean salad'},
    {'path': 'assets/images/lunch2.jpeg', 'title': 'Mditerrean tuna salad'},
    {'path': 'assets/images/lunch3.png', 'title': 'Ramen'},
    {
      'path': 'assets/images/lunch4.jpeg',
      'title': 'Cumin-roasted carrot & cauliflowe'
    },
    {'path': 'assets/images/lunch5.jpeg', 'title': 'Amatriciana'},
    {'path': 'assets/images/lunch6.jpeg', 'title': 'Sautéed shrimp'},
    {'path': 'assets/images/lunch7.jpeg', 'title': 'Healthy sandwish'},
    {'path': 'assets/images/lunch8.png', 'title': 'Salad'},
    {'path': 'assets/images/lunch1.png', 'title': 'Bean salad'},
    {'path': 'assets/images/lunch2.jpeg', 'title': 'Mditerrean tuna salad'},
    {'path': 'assets/images/lunch3.png', 'title': 'Ramen'},
    {
      'path': 'assets/images/lunch4.jpeg',
      'title': 'Cumin-roasted carrot & cauliflowe'
    },
    {'path': 'assets/images/lunch5.jpeg', 'title': 'Amatriciana'},
    {'path': 'assets/images/lunch6.jpeg', 'title': 'Sautéed shrimp'},
    {'path': 'assets/images/lunch7.jpeg', 'title': 'Healthy sandwish'},
    {'path': 'assets/images/lunch8.png', 'title': 'Salad'},
    {'path': 'assets/images/dinner1.jpeg', 'title': 'Sesame chicken'},
    {'path': 'assets/images/dinner2.jpeg', 'title': 'Roasted potatoes'},
    {'path': 'assets/images/dinner3.jpeg', 'title': 'Kale and marinara pasta'},
    {
      'path': 'assets/images/dinner4.jpeg',
      'title': 'Teriyaki Salmon Sushi Bowl'
    },
    {
      'path': 'assets/images/dinner6.jpeg',
      'title': 'Garlic Butter Steak and Potatoes'
    },
    {'path': 'assets/images/dinner7.jpeg', 'title': 'lemon chicken skewers'},
    {
      'path': 'assets/images/dinner8.jpeg',
      'title': 'Grilled chicken and vegetables'
    },
    {'path': 'assets/images/dinner1.jpeg', 'title': 'Sesame chicken'},
    {'path': 'assets/images/dinner2.jpeg', 'title': 'Roasted potatoes'},
    {'path': 'assets/images/dinner3.jpeg', 'title': 'Kale and marinara pasta'},
    {
      'path': 'assets/images/dinner4.jpeg',
      'title': 'Teriyaki Salmon Sushi Bowl'
    },
    {'path': 'assets/images/dinner5.jpeg', 'title': 'Chicken Pot Pie Soup'},
    {
      'path': 'assets/images/dinner6.jpeg',
      'title': 'Garlic Butter Steak and Potatoes'
    },
    {'path': 'assets/images/dinner7.jpeg', 'title': 'lemon chicken skewers'},
    {
      'path': 'assets/images/dinner8.jpeg',
      'title': 'Grilled chicken and vegetables'
    },
    {'path': 'assets/images/dinner5.jpeg', 'title': 'Chicken Pot Pie Soup'},
    {'path': 'assets/images/recipe1.jpeg', 'title': 'Banana Berry Acai Bowl'},
    {'path': 'assets/images/recipe2.jpeg', 'title': 'Smoothie Bowl'},
    {
      'path': 'assets/images/recipe3.jpeg',
      'title': 'Avocado toast with tomato'
    },
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Cilantro Lime Avocado Toast'
    },
    {'path': 'assets/images/recipe5.jpeg', 'title': 'Fruit'},
    {'path': 'assets/images/recipe6.jpeg', 'title': 'Kimchi'},
    {'path': 'assets/images/recipe7.jpeg', 'title': 'Fruits'},
    {'path': 'assets/images/recipe3.jpeg', 'title': 'Yogurt Parfait'},
    {'path': 'assets/images/recipe9.jpeg', 'title': 'Egg Breakfast Bowl'},
    {'path': 'assets/images/recipe1.jpeg', 'title': 'Fruits'},
    {'path': 'assets/images/recipe1.jpeg', 'title': 'Banana Berry Acai Bowl'},
    {'path': 'assets/images/recipe2.jpeg', 'title': 'Smoothie Bowl'},
    {
      'path': 'assets/images/recipe3.jpeg',
      'title': 'Avocado toast with tomato'
    },
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Cilantro Lime Avocado Toast'
    },
    {'path': 'assets/images/recipe5.jpeg', 'title': 'Fruit'},
    {'path': 'assets/images/recipe6.jpeg', 'title': 'Kimchi'},
    {'path': 'assets/images/recipe7.jpeg', 'title': 'Fruits'},
    {'path': 'assets/images/recipe3.jpeg', 'title': 'Yogurt Parfait'},
    {'path': 'assets/images/recipe9.jpeg', 'title': 'Egg Breakfast Bowl'},
    {'path': 'assets/images/recipe1.jpeg', 'title': 'Fruits'},
  ];

  // Shuffle the imageData list when the widget initializes
  @override
  void initState() {
    super.initState();
    imageData.shuffle();
    filteredImageData = List.from(imageData);
  }

  // List to store the favorite images
  List<String> favoriteImages = [];
  List<Map<String, String>> filteredImageData = [];
  TextEditingController searchController = TextEditingController();

  void toggleFavorite(String imagePath) {
    setState(() {
      if (favoriteImages.contains(imagePath)) {
        favoriteImages.remove(imagePath);
      } else {
        favoriteImages.add(imagePath);
      }
    });
  }

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

  void navigateToDetailPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RecipeDetailPage(recipeData: filteredImageData[index]),
      ),
    );
  }

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
        appBarTitle: 'Recipe',
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
