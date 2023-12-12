import 'package:flutter/material.dart';
import '../../../../commons/colors.dart';

class AppTextStyles {
  static const TextStyle welcomeTitle = TextStyle(
    fontFamily: 'Lobster',
    fontSize: 66,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColor,
    letterSpacing: -0.84,
    height: 1.2,
  );

  static const TextStyle getStartedButton = TextStyle(
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

  static const TextStyle alreadyMember = TextStyle(
    color: Colors.black,
    fontFamily: 'Noto Sans HK',
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.37,
  );

  static const TextStyle todayTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 19,
    fontWeight: FontWeight.w500,
    height: 21 / 14,
    letterSpacing: 0,
    color: AppColors.greyColorHome,
  );
}
