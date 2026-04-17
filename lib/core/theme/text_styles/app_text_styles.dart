import 'package:flutter/material.dart';

import 'base_text_styles.dart';
import 'open_sans_styles.dart';

/// Главная точка доступа к типографике приложения.
class AppTextStyles extends BaseTextStyles {
  const AppTextStyles() : super(openSansStyles: const OpenSansStyles());

  TextTheme buildTextTheme({
    required Color primaryTextColor,
    required Color secondaryTextColor,
  }) {
    return TextTheme(
      displayLarge: openSansStyles.extraBoldOpenSans57.copyWith(
        color: primaryTextColor,
        letterSpacing: -1.5,
        height: 1.05,
      ),
      displayMedium: openSansStyles.extraBoldOpenSans45.copyWith(
        color: primaryTextColor,
        letterSpacing: -1.0,
        height: 1.1,
      ),
      displaySmall: openSansStyles.boldOpenSans36.copyWith(
        color: primaryTextColor,
        letterSpacing: -0.5,
        height: 1.15,
      ),
      headlineLarge: openSansStyles.boldOpenSans32.copyWith(
        color: primaryTextColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: openSansStyles.boldOpenSans28.copyWith(
        color: primaryTextColor,
      ),
      headlineSmall: openSansStyles.semiBoldOpenSans24.copyWith(
        color: primaryTextColor,
      ),
      titleLarge: openSansStyles.semiBoldOpenSans22.copyWith(
        color: primaryTextColor,
      ),
      titleMedium: openSansStyles.semiBoldOpenSans16.copyWith(
        color: primaryTextColor,
      ),
      titleSmall: openSansStyles.mediumOpenSans14.copyWith(
        color: secondaryTextColor,
      ),
      bodyLarge: openSansStyles.openSans16.copyWith(
        color: primaryTextColor,
        height: 1.6,
      ),
      bodyMedium: openSansStyles.openSans14.copyWith(
        color: secondaryTextColor,
        height: 1.6,
      ),
      bodySmall: openSansStyles.openSans12.copyWith(
        color: secondaryTextColor,
        height: 1.5,
      ),
      labelLarge: openSansStyles.semiBoldOpenSans14.copyWith(
        color: primaryTextColor,
      ),
      labelMedium: openSansStyles.mediumOpenSans12.copyWith(
        color: secondaryTextColor,
      ),
      labelSmall: openSansStyles.mediumOpenSans11.copyWith(
        color: secondaryTextColor,
        letterSpacing: 0.5,
      ),
    );
  }

  @override
  ThemeExtension<BaseTextStyles> copyWith() => const AppTextStyles();

  @override
  ThemeExtension<BaseTextStyles> lerp(
    covariant ThemeExtension<BaseTextStyles>? other,
    double t,
  ) {
    if (other is AppTextStyles) return this;
    return const AppTextStyles();
  }
}
