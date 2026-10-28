import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.forestGreen,
      scaffoldBackgroundColor: AppColors.ivoryBg,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.forestGreen,
        onPrimary: Colors.white,
        secondary: AppColors.gold,
        onSecondary: AppColors.forestGreenDark,
        surface: AppColors.ivoryBg,
        onSurface: AppColors.textCharcoal,
        error: AppColors.error,
        onError: Colors.white,
      ),
      fontFamily: 'Plus Jakarta Sans',
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.heroTitle(),
        headlineLarge: AppTypography.sectionTitle(),
        headlineMedium: AppTypography.cardTitle(),
        bodyLarge: AppTypography.body(fontSize: 16),
        bodyMedium: AppTypography.body(fontSize: 14),
      ),
    );
  }
}

