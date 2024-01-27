import 'commons.dart';
import 'favorite_page.dart';
import 'recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import '../home/home_widgets/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SnackPage extends StatefulWidget {
  @override
  _SnackPageState createState() => _SnackPageState();
}

class _SnackPageState extends State<SnackPage> {
  
  // List of image data (path and title)
  final List<Map<String, String>> imageData = [
    {
      'path': 'assets/images/snack1.jpeg',
      'title': 'Frozen Vanilla Berry Bark',
      'ingredients': '''
        Greek Yogurt
        Mixed Berries
        Honey
        Vanilla Extract
      ''',
      'recipe': '''
        1. Mix Greek yogurt, honey, and vanilla extract in a bowl.
        2. Spread the mixture on a baking sheet.
        3. Sprinkle mixed berries on top.
        4. Freeze until solid, then break into pieces.
      ''',
    },
    {
      'path': 'assets/images/snack2.jpeg',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack3.jpeg',
      'title': 'Apple Peanut Butter',
      'ingredients': '''
        Apples
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Slice apples.
        2. Spread peanut butter on apple slices.
        3. Sprinkle chocolate chips on top.
      ''',
    },
    {
      'path': 'assets/images/snack4.jpeg',
      'title': 'Frozen Yogurt',
      'ingredients': '''
        Greek Yogurt
        Honey
        Berries
      ''',
      'recipe': '''
        1. Mix Greek yogurt and honey in a bowl.
        2. Add berries and mix well.
        3. Freeze until firm.
      ''',
    },
    {
      'path': 'assets/images/snack5.png',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack6.jpeg',
      'title': 'Healthy Cookies',
      'ingredients': '''
        Rolled Oats
        Banana
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mash bananas in a bowl.
        2. Add rolled oats, peanut butter, and chocolate chips.
        3. Mix well and form into cookies.
        4. Bake in the oven until golden brown.
      ''',
    },
    {
      'path': 'assets/images/snack7.jpeg',
      'title': 'Fruits',
      'ingredients': '''
        Assorted Fruits (e.g., Strawberries, Grapes, Kiwi)
      ''',
      'recipe': '''
        1. Wash and chop assorted fruits.
        2. Arrange them on a plate.
      ''',
    },
    {
      'path': 'assets/images/snack8.jpeg',
      'title': 'Greek Yogurt Brownies',
      'ingredients': '''
        Greek Yogurt
        Cocoa Powder
        Honey
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix Greek yogurt, cocoa powder, honey, and chocolate chips in a bowl.
        2. Pour into a baking pan and spread evenly.
        3. Bake in the oven until set.
      ''',
    },
    {
      'path': 'assets/images/snack1.jpeg',
      'title': 'Frozen Vanilla Berry Bark',
      'ingredients': '''
        Greek Yogurt
        Mixed Berries
        Honey
        Vanilla Extract
      ''',
      'recipe': '''
        1. Mix Greek yogurt, honey, and vanilla extract in a bowl.
        2. Spread the mixture on a baking sheet.
        3. Sprinkle mixed berries on top.
        4. Freeze until solid, then break into pieces.
      ''',
    },
    {
      'path': 'assets/images/snack2.jpeg',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack3.jpeg',
      'title': 'Apple Peanut Butter',
      'ingredients': '''
        Apples
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Slice apples.
        2. Spread peanut butter on apple slices.
        3. Sprinkle chocolate chips on top.
      ''',
    },
    {
      'path': 'assets/images/snack4.jpeg',
      'title': 'Frozen Yogurt',
      'ingredients': '''
        Greek Yogurt
        Honey
        Berries
      ''',
      'recipe': '''
        1. Mix Greek yogurt and honey in a bowl.
        2. Add berries and mix well.
        3. Freeze until firm.
      ''',
    },
    {
      'path': 'assets/images/snack5.png',
      'title': 'Energy Bar',
      'ingredients': '''
        Oats
        Almonds
        Honey
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix oats, almonds, honey, and peanut butter in a bowl.
        2. Add chocolate chips and mix well.
        3. Press the mixture into a baking pan.
        4. Refrigerate until firm, then cut into bars.
      ''',
    },
    {
      'path': 'assets/images/snack6.jpeg',
      'title': 'Healthy Cookies',
      'ingredients': '''
        Rolled Oats
        Banana
        Peanut Butter
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mash bananas in a bowl.
        2. Add rolled oats, peanut butter, and chocolate chips.
        3. Mix well and form into cookies.
        4. Bake in the oven until golden brown.
      ''',
    },
    {
      'path': 'assets/images/snack7.jpeg',
      'title': 'Fruits',
      'ingredients': '''
        Assorted Fruits (e.g., Strawberries, Grapes, Kiwi)
      ''',
      'recipe': '''
        1. Wash and chop assorted fruits.
        2. Arrange them on a plate.
      ''',
    },
    {
      'path': 'assets/images/snack8.jpeg',
      'title': 'Greek Yogurt Brownies',
      'ingredients': '''
        Greek Yogurt
        Cocoa Powder
        Honey
        Chocolate Chips
      ''',
      'recipe': '''
        1. Mix Greek yogurt, cocoa powder, honey, and chocolate chips in a bowl.
        2. Pour into a baking pan and spread evenly.
        3. Bake in the oven until set.
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
    final favoriteImagesList = _prefs?.getStringList('snackFavoriteImages') ?? [];
    setState(() {
      favoriteImages = favoriteImagesList;
    });
  }

  // List to store the favorite images
  List<String> favoriteImages = [];
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
    await _prefs?.setStringList('snackFavoriteImages', favoriteImages);
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
        appBarTitle: 'Snack',
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
