import 'widgets/widgets.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeTitle(),
            WelcomeImageStack(),
            const SizedBox(height: 16),
            BottomSection(),
          ],
        ),
      ),
      ),
    );
  }
}
