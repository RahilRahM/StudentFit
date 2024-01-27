import 'package:flutter/material.dart';
import '../home/home_widgets/app_bar.dart';
import 'package:StudentFit/commons/index.dart';
import 'package:StudentFit/screens/premium/index.dart';
import 'package:StudentFit/screens/welcomePages/widgets/widgets.dart';

class presPage extends StatefulWidget {
  @override
  _presPageState createState() => _presPageState();
}

class _presPageState extends State<presPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Meal Planning',
        showFavoriteIcon: false,
        onFavoritePressed: () {},
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RecipeCarousel(),
            Container(
              width: 360,
              height: 66,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: const Text(
                'Pick your meal depending\non vegetable of your choice',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Noto Sans HK',
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.27,
                  height: 1.33333,
                ),
              ),
            ),
            const SizedBox(height: 50),
            CustomElevatedButton2(
                buttonText: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VegetablesPage(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
