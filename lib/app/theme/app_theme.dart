import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.accentSecondary,
      surface: AppColors.darkSurface,
      surfaceContainerHighest: AppColors.darkSurfaceAlt,
      onSurface: AppColors.darkTextPrimary,
      onPrimary: Colors.white,
      outline: AppColors.darkBorder,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      canvasColor: AppColors.darkBackground,
      textTheme: AppTypography.buildTextTheme(
        AppColors.darkTextPrimary,
        AppColors.darkTextSecondary,
      ),
      dividerColor: AppColors.darkBorder,
      iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
    );
  }

  static ThemeData get light {
    const scheme = ColorScheme.light(
      primary: AppColors.accent,
      secondary: AppColors.accentSecondary,
      surface: AppColors.lightSurface,
      surfaceContainerHighest: AppColors.lightSurfaceAlt,
      onSurface: AppColors.lightTextPrimary,
      onPrimary: Colors.white,
      outline: AppColors.lightBorder,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      canvasColor: AppColors.lightBackground,
      textTheme: AppTypography.buildTextTheme(
        AppColors.lightTextPrimary,
        AppColors.lightTextSecondary,
      ),
      dividerColor: AppColors.lightBorder,
      iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
    );
  }
}
