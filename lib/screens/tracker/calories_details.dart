import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import 'package:StudentFit/commons/index.dart';

class CaloriesDetailPage extends StatelessWidget {
  final Map<String, String> recipeData;

  CaloriesDetailPage({required this.recipeData});
  final List<Map<String, String>> menuList = [
    {
      'path': 'assets/images/breakfast.png',
      'title': 'Smoothie bowl',
      'energy': '100k',
      'protein': '15g',
      'carbs': '58g',
      'fat': '20g'
    },
    {
      'path': 'assets/images/lunch3.png',
      'title': 'Cumin-roasted carrot & cauliflower',
      'energy': '200k',
      'protein': '25g',
      'carbs': '30g',
      'fat': '15g'
    },
    {
      'path': 'assets/images/snack4.jpeg',
      'title': 'Frozen Vanilla berry bark',
      'energy': '150k',
      'protein': '10g',
      'carbs': '40g',
      'fat': '18g'
    },
    {
      'path': 'assets/images/dinner3.jpeg',
      'title': 'Sesame chicken',
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
        appBarTitle: 'Suggested Menu',
        showFavoriteIcon: false,
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      backgroundColor: Colors.white,
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
            child: Text(
              recipeData['title']!,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
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
            ),
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
