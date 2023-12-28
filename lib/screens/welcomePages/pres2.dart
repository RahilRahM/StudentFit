import 'widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:student_fit/screens/signup/SignUp.dart';





class Pres3 extends StatelessWidget {
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
              title: 'Planner',
              onBack: () {
                Navigator.pop(context);
              },
              onForward: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
            SizedBox(height: screenPadding(context, 0.08)),
            PlannerCarousel(),
            SizedBox(height: screenPadding(context, 0.12)),
            PlannerCarouselTextLines(
              title: 'Maximize your planning efficiency',
              lines: ['Relax and simplify your scheduling','We\'re here to elevate your calendar and task management experience',],
            ),
            SizedBox(height: screenPadding(context, 0.15)),
          ],
        ),
      ),
    );
  }
}
