import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.grid,
        onPrimary: Colors.white,
        surface: AppColors.background,
        onSurface: Colors.white,
      ),
    );
  }
}
