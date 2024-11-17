import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF492E9E); //primary color
  static const Color backgroundColor1 = Color(0xFFECD0FF); //background
  static const Color backgroundColor2 = Color(0xFFFAF1FF); //background 2
  static const Color cardColor = Color(0xFFEFEFEF); // Card background color
  static const Color textColor = Color(0xFF101010); // Text color
  static const Color textColor2 = Color(0xFF6D6D6D); // Text color2
  static const Color errorColor = Colors.red; // Error color
  static const Color buttonHoverColor = Color(0xFF311E6D); //Hover color
}

// Text Styles
class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle buttonText2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle descriptionText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor2,
  );

  static const TextStyle blogTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle blogDescription = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static const TextStyle brandNameText = TextStyle(
    fontFamily: 'BrunoAceSC',
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColor,
    letterSpacing: 5,
  );
}
