import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
      background: AppColors.backgroundLight,
      error: AppColors.errorLight,
      onPrimary: AppColors.onPrimaryLight,
      onSecondary: AppColors.onSecondaryLight,
      onSurface: AppColors.onSurfaceLight,
      onBackground: AppColors.onBackgroundLight,
      onError: AppColors.onErrorLight,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.headline1Light,
      displayMedium: AppTextStyles.headline2Light,
      bodyLarge: AppTextStyles.bodyText1Light,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      background: AppColors.backgroundDark,
      error: AppColors.errorDark,
      onPrimary: AppColors.onPrimaryDark,
      onSecondary: AppColors.onSecondaryDark,
      onSurface: AppColors.onSurfaceDark,
      onBackground: AppColors.onBackgroundDark,
      onError: AppColors.onErrorDark,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.headline1Dark,
      displayMedium: AppTextStyles.headline2Dark,
      bodyLarge: AppTextStyles.bodyText1Dark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
  );

  static ThemeMode getThemeMode() {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  static void changeTheme() {
    final box = GetStorage();
    bool isDarkMode = box.read('isDarkMode') ?? false;
    box.write('isDarkMode', !isDarkMode);
  }
}