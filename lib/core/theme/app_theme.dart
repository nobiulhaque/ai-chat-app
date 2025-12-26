import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.black,
      cardColor: AppColors.white,
      splashColor: Colors.transparent,
      // shadowColor: AppColors.shadowColor,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.white,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.black,
        error: AppColors.appRed,
        onError: AppColors.white,
        surface: AppColors.black,
        onSurface: AppColors.white,
      ),

      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      textTheme: AppTextTheme.dark,
      inputDecorationTheme: InputDecorationThemeData(
        border: InputBorder.none,
        // Also apply it to other border states for consistency.
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
