import 'package:flutter/material.dart';
import 'package:student_fit/commons/colors.dart';
import 'package:student_fit/screens/welcomePages/widgets/app_text_styles.dart';

class CustomElevatedButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;

  CustomElevatedButton2({
    required this.buttonText,
    required this.onPressed,
    this.width = 250, // default width
    this.height = 60, // default height
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
