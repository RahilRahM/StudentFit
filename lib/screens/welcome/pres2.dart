import 'pres3.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';

class Pres2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Planner',
              onBack: () {Navigator.pop(context);},
              onForward: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pres3()),
                );
              },
            ),
            RecipeCarouselTextLines(
              title: 'Maximize your planning efficiency',
              lines: [ 'Relax and simplify your scheduling','We\'re here to elevate your Calendar and task management experience', ],
            ),
            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}
