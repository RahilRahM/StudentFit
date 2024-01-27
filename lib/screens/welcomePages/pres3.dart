import 'widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:StudentFit/screens/welcomePages/pres2.dart';

class Pres2 extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: 'Daily reminder',
                onBack: () {
                  Navigator.pop(context);
                },
                onForward: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pres3()),
                  );
                },
              ),
              SizedBox(height: screenPadding(context, 0.01)),
              Image.asset(
                'assets/images/img3.png',
                width: screenWidth(context),
                height: screenHeight(context) * 0.4,
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenPadding(context, 0.01)),
              RecipeCarouselTextLines(
                title: 'Enhance your daily reminders',
                lines: [
                  'Stay organized with precise daily alerts',
                  'We\'re here to elevate your reminder experience with accuracy',
                ],
              ),
              SizedBox(height: screenPadding(context, 0.055)),
            ],
          ),
        ),
      ),
    );
  }
}
