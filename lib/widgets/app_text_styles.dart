import '../../commons/colors.dart';
import 'package:flutter/material.dart';


class AppTextStyles {
  static final TextStyle welcomeTitle = TextStyle(
    fontFamily: 'Lobster',
    fontSize: 66,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColor,
    letterSpacing: -0.84,
    height: 1.2,
  );

  static final TextStyle getStartedButton = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle recipesTitle = TextStyle(
    fontFamily: 'Lobster',
    fontSize: 37,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 2,
    color: AppColors.blackColor,
    shadows: [
      Shadow(
        offset: const Offset(2, 2),
        color: AppColors.blackColor.withOpacity(0.3),
        blurRadius: 3,
      ),
    ],
  );

  static final TextStyle alreadyMember = TextStyle(
    color: Colors.black,
    fontFamily: 'Noto Sans HK',
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.37,
  );
}
