import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/core/theme/app_theme.dart';

class ThemeSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Obx(() {
        final isDark = Get.isDarkMode;
        return Icon(isDark ? Icons.light_mode : Icons.dark_mode);
      }),
      onPressed: AppTheme.changeTheme,
      tooltip: 'Alternar Tema',
    );
  }
}