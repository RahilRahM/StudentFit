import 'package:flutter/material.dart';
import 'package:StudentFit/screens/home/home_widgets/app_bar.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map<String, String> recipeData;

  RecipeDetailPage({required this.recipeData});

  @override
  Widget build(BuildContext context) {
    final String title = recipeData['title']!;
    final String imagePath = recipeData['path']!;
    final List<String> ingredients = recipeData['ingredients']!.split('\n');
    final List<String> instructions = recipeData['recipe']!.split('\n');

    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: recipeData['title']!,
        showFavoriteIcon: false,
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: 360,
              height: 68,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  237,
                  235,
                  235,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('100k'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('15g'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('58g'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('20g'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Energy'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Protein'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Carbs'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Fat'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 8.0),
            Container(
              width: 200,
              height: 39,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Ingredients:',
                style: TextStyle(
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      color: Color.fromRGBO(
                        0,
                        0,
                        0,
                        0.15,
                      ),
                    ),
                  ],
                  fontFamily: 'Noto Sans HK',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 290,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 30),
                  children: ingredients.map((ingredient) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        ingredient.trim(),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 39,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Instructions:',
                style: TextStyle(
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      color: Color.fromRGBO(
                        0,
                        0,
                        0,
                        0.15,
                      ),
                    ),
                  ],
                  fontFamily: 'Noto Sans HK',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(
              width: 290,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 30),
                  children: instructions.map((instruction) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        instruction.trim(),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
