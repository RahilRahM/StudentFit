import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import 'package:student_fit/commons/index.dart';

class MenuPage extends StatelessWidget {
  final Map<String, String> recipeData;

  MenuPage({required this.recipeData});
  final List<Map<String, String>> menuList = [
    {
      'path': 'assets/images/recipe4.jpeg',
      'title': 'Breakfast',
      'energy': '100k',
      'protein': '15g',
      'carbs': '58g',
      'fat': '20g'
    },
    {
      'path': 'assets/images/lunch3.png',
      'title': 'Lunch',
      'energy': '200k',
      'protein': '25g',
      'carbs': '30g',
      'fat': '15g'
    },
    {
      'path': 'assets/images/snack1.jpeg',
      'title': 'Snack',
      'energy': '150k',
      'protein': '10g',
      'carbs': '40g',
      'fat': '18g'
    },
    {
      'path': 'assets/images/dinner6.jpeg',
      'title': 'Dinner',
      'energy': '180k',
      'protein': '20g',
      'carbs': '45g',
      'fat': '22g'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Your menu',
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
          children: menuList
              .map((menuData) => MenuWidget(recipeData: menuData))
              .toList(),
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  final Map<String, String> recipeData;

  MenuWidget({required this.recipeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 350.0,
              height: 36.0,
              child: Center(
                child: Text(
                  recipeData['title']!,
                  style: const TextStyle(
                    color: AppColors.primaryColor, // Adjust color as needed
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.39,
                    fontFamily: 'Noto Sans HK',
                  ),
                ),
              ),
            ),
          ),
        ),
        Image.asset(
          recipeData['path']!,
          fit: BoxFit.cover,
          height: 150.0,
          width: double.infinity, // Adjust the height as needed
        ),
        const SizedBox(height: 0.0),
        Container(
          width: double.infinity,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Energy',
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recipeData['energy']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.redColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(recipeData['protein']!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(recipeData['carbs']!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(recipeData['fat']!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
