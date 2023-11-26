import 'pres2.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';

class Pres1 extends StatelessWidget {
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
            const SizedBox(height: 44),
            RecipeCarousel(),
            const SizedBox(height: 60),
            RecipeCarouselTextLines(
              title: 'Enjoy Your Lunch Time',
              lines: [ 'Just relax and not overthink what to eat.',
                'We\'re here to make your lunch time experience even better',
              ],
            ),
            
            const SizedBox(height: 40),
        
          ],
        ),
      ),
    );
  }
}
