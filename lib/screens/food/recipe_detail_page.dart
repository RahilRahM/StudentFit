import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map<String, String> recipeData;

  RecipeDetailPage({required this.recipeData});

  final List<String> instructions = [
    '1. Gather Fresh Ingredients',
    '2. Wash and Chop Veggies',
    '3. Prepare Protein Source',
    '4. Add Healthy Fats',
    '5. Include Whole Grains',
    '6. Mix in Fresh Herbs',
    '7. Prepare a Light Dressing',
    '8. Toss the Salad',
    '9. Season with Salt and Pepper',
    '10. Serve Immediately',
  ];

  
  void _showInstructionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: ListView.builder(
            physics:
                const BouncingScrollPhysics(),
            itemCount: instructions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  instructions[index],
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
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
              recipeData['path']!,
              fit: BoxFit.cover,
              height: 200.0, // Adjust the height as needed
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  recipeData['title']!,
                  style: const TextStyle(
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
                ), // Grey background color
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
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
            Container(
              width: 190,
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
            SizedBox(
              width: 290,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  padding: const EdgeInsets.only(left: 30),
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    Text(
                      'Fresh vegetables, greens',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tomatoes, onions',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Avocado, nuts/seeds',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tomatoes, onions',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Avocado, nuts/seeds',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tomatoes, onions',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Avocado, nuts/seeds',
                      style: TextStyle(
                        fontSize: 18.0, // Adjust the font size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: 200,
              height: 39,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Instruction:',
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
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 30),
                  children: instructions.map((instruction) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        instruction,
                        style: const TextStyle(
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
