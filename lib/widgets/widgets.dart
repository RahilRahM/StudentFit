import 'app_text_styles.dart';
import '../commons/colors.dart';
import '../screens/welcome/pres1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../screens/Subscription/login.dart';
import 'package:carousel_slider/carousel_slider.dart';


class WelcomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 1),
        child: Text(
          'StudentFit',
          style: AppTextStyles.welcomeTitle,
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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


class WelcomeImageStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/img1.png',
          width: 660,
          height: 600,
        ),
        Positioned(
          bottom: 25,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Pres1 page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pres1()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(200, 60),
            ),
            child: Text(
              'Get Started',
              style: AppTextStyles.getStartedButton,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: SizedBox(
        width: 360,
        height: 28,
        child: RichText(
          text: TextSpan(
            text: 'Already a member? ',
            style: AppTextStyles.alreadyMember,
            children: [
              TextSpan(
                text: 'Log in',
                style: const TextStyle(
                  fontSize: 19,
                  color:  AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to the login page when "Log in" is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInPage()),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onForward;

  CustomAppBar({
    required this.title,
    required this.onBack,
    required this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back,
              size: 40,
              color: AppColors.blackColor,
            ),
          ),
          Text(
            title,
            style: AppTextStyles.recipesTitle,
          ),
          IconButton(
            onPressed: onForward,
            icon: const Icon(
              Icons.arrow_forward,
              size: 40,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}


class RecipeCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 400,
          viewportFraction: 0.3,
        ),
        items: [
          RecipeImage('assets/images/pres1.png'),
          RecipeImage('assets/images/pres2.png'),
          RecipeImage('assets/images/pres3.png'),
          RecipeImage('assets/images/pres4.png'),
          RecipeImage('assets/images/pres5.png'),
          RecipeImage('assets/images/pres6.png'),
          RecipeImage('assets/images/pres7.png'),
          RecipeImage('assets/images/pres8.png'),
          RecipeImage('assets/images/pres9.png'),
        ],
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  final String imagePath;

  RecipeImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class RecipeCarouselTextLines extends StatelessWidget {
  final String title;
  final List<String> lines;

  RecipeCarouselTextLines({
    required this.title,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextWidget(title, isTitle: true),
          for (String line in lines) _buildTextWidget(line),
        ],
      ),
    );
  }

  Widget _buildTextWidget(String text, {bool isTitle = false}) {
    return Container(
      margin: EdgeInsets.only(
        top: isTitle ? 0 : 20,
        right: isTitle ? 20 : 0,
        left: isTitle ? 20 : 0,
      ),
      padding: EdgeInsets.symmetric(horizontal: isTitle ? 0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: isTitle ? 'Arial' : 'Monaco',
              fontSize: isTitle ? 30 : 23,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.w400,
              height: isTitle ? 1.2 : 1.4,
              letterSpacing: 0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
