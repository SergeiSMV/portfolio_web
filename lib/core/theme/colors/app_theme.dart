import 'package:flutter/material.dart';

import 'app_colors.dart';
import '../text_styles/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    const appTextStyles = AppTextStyles();
    const colors = AppColors.dark();
    final scheme = ColorScheme.dark(
      primary: colors.mainColors.accent,
      secondary: colors.mainColors.accentSecondary,
      surface: colors.mainColors.surface,
      surfaceContainerHighest: colors.mainColors.surfaceAlt,
      onSurface: colors.textColors.primary,
      onPrimary: colors.mainColors.onPrimary,
      outline: colors.mainColors.border,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.mainColors.background,
      canvasColor: colors.mainColors.background,
      textTheme: appTextStyles.buildTextTheme(
        primaryTextColor: colors.textColors.primary,
        secondaryTextColor: colors.textColors.secondary,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppTextStyles(),
        colors,
      ],
      dividerColor: colors.elementColors.divider,
      iconTheme: IconThemeData(color: colors.elementColors.icon),
    );
  }

  static ThemeData get light {
    const appTextStyles = AppTextStyles();
    const colors = AppColors.light();
    final scheme = ColorScheme.light(
      primary: colors.mainColors.accent,
      secondary: colors.mainColors.accentSecondary,
      surface: colors.mainColors.surface,
      surfaceContainerHighest: colors.mainColors.surfaceAlt,
      onSurface: colors.textColors.primary,
      onPrimary: colors.mainColors.onPrimary,
      outline: colors.mainColors.border,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.mainColors.background,
      canvasColor: colors.mainColors.background,
      textTheme: appTextStyles.buildTextTheme(
        primaryTextColor: colors.textColors.primary,
        secondaryTextColor: colors.textColors.secondary,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppTextStyles(),
        colors,
      ],
      dividerColor: colors.elementColors.divider,
      iconTheme: IconThemeData(color: colors.elementColors.icon),
    );
  }
}
