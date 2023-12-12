import 'widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/screens/welcomePages/pres3.dart';



class Pres1 extends StatelessWidget {
  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double screenPadding(BuildContext context, double percent) {
    return screenWidth(context) * percent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Recipes',
              onBack: () {
                Navigator.pop(context);
              },
              onForward: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pres2()),
                );
              },
            ),
            SizedBox(height: screenPadding(context, 0.08)),
            RecipeCarousel(),
            SizedBox(height: screenPadding(context, 0.12)),
            RecipeCarouselTextLines(
              title: 'Enjoy Your Lunch Time',
              lines: ['Just relax and not overthink what to eat.','We\'re here to make your lunch time experience even better',],
            ),
            SizedBox(height: screenPadding(context, 0.15)),
          ],
        ),
      ),
    );
  }
}
