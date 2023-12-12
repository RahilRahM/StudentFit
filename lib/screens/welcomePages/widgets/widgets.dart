import '../pres1.dart';
import 'app_text_styles.dart';
import '../../login/login.dart';
import '../../../commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:carousel_slider/carousel_slider.dart';


class WelcomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: screenHeight * 0.02),
        child: const Text(
          'StudentFit',
          style: AppTextStyles.welcomeTitle,
        ),
      ),
    );
  }
}



class WelcomeImageStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/img1.png',
          width: screenWidth * 1.1,  // Adjust the width as needed
          height: screenHeight * 0.65, // Adjust the height as needed
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: screenHeight * 0.05, // Adjust the bottom position as needed
          child: CustomElevatedButton(
            buttonText: 'Get Started',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pres1()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;

  CustomElevatedButton({
    required this.buttonText,
    required this.onPressed,
    this.width = 200, // default width
    this.height = 60, // default height
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(width, height),
      ),
      child: Text(
        buttonText,
        style: AppTextStyles.getStartedButton,
      ),
    );
  }
}


class BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(90, 0, 20, 0),
      child: SizedBox(
        width: double.infinity, 
        height: 25,
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
    double iconSize = MediaQuery.of(context).size.width * 0.08;

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
             Icons.arrow_back_ios,
              size: iconSize,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.recipesTitle,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: onForward,
            icon: Icon(
              Icons.arrow_forward_ios,
              size: iconSize,
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


class PlannerCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 400,
          viewportFraction: 0.3,
        ),
        items: [
          PlannerImage('assets/images/planner1.jpg'),
          PlannerImage('assets/images/planner2.jpg'),
          PlannerImage('assets/images/planner3.jpg'),
          PlannerImage('assets/images/planner4.jpg'),
          PlannerImage('assets/images/planner5.jpg'),
          PlannerImage('assets/images/planner1.jpg'),
          PlannerImage('assets/images/planner2.jpg'),  
          PlannerImage('assets/images/planner3.jpg'),
          PlannerImage('assets/images/planner4.jpg'),
          PlannerImage('assets/images/planner5.jpg'),
          PlannerImage('assets/images/planner1.jpg'),
          PlannerImage('assets/images/planner2.jpg'),  
        ],
      ),
    );
  }
}

class PlannerImage extends StatelessWidget {
  final String imagePath;

  PlannerImage(this.imagePath);

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

class PlannerCarouselTextLines extends StatelessWidget {
  final String title;
  final List<String> lines;

  PlannerCarouselTextLines({
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

