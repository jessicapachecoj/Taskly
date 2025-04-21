import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Light Theme
  static const TextStyle headline1Light = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackgroundLight,
  );

  static const TextStyle headline2Light = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackgroundLight,
  );

  static const TextStyle bodyText1Light = TextStyle(
    fontSize: 16,
    color: AppColors.onBackgroundLight,
  );

  // Dark Theme
  static const TextStyle headline1Dark = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackgroundDark,
  );

  static const TextStyle headline2Dark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackgroundDark,
  );

  static const TextStyle bodyText1Dark = TextStyle(
    fontSize: 16,
    color: AppColors.onBackgroundDark,
  );

  // Common
  static TextStyle buttonText(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onPrimary,
    );
  }
}