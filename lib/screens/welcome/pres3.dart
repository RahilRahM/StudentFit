import '../Subscription/login.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';

class Pres3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  MaterialPageRoute(builder: (context) => LogInPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/img3.png', 
              width: double.infinity, 
              height: 400, 
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            RecipeCarouselTextLines(
              title: 'Enhance your daily reminders',
              lines: ['Stay organized with precise daily alerts','We\'re here to elevate your reminder experience with accuracy'],
            ),
            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}
