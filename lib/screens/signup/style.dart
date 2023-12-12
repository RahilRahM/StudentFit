import 'package:flutter/material.dart';
import '../../commons/colors.dart';

// SignUp Pages Text Styles
const TextStyle textBg = TextStyle(
  fontFamily: 'Inter',
  fontSize: 30.0,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const TextStyle textSm = TextStyle(
  fontFamily: 'Inter',
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

// Button Styles
final ButtonStyle button_back = ElevatedButton.styleFrom(
  backgroundColor:  AppColors.grey1,
  textStyle: TextStyle(fontSize: 25.0),
  fixedSize: Size(150, 50),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
);

final ButtonStyle button_next = ElevatedButton.styleFrom(
  backgroundColor: AppColors.primaryColor,
  textStyle: TextStyle(fontSize: 25.0),
  minimumSize: Size(150, 50),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
);
