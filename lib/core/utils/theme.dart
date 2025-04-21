import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(color: Colors.blue),
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
    appBarTheme: const AppBarTheme(color: Colors.blueGrey),
  );

  static void changeTheme() {
    final storage = GetStorage();
    final isDark = storage.read('isDark') ?? false;
    storage.write('isDark', !isDark);
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  static ThemeMode getThemeMode() {
    final storage = GetStorage();
    final isDark = storage.read('isDark') ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }
}