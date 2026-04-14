import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextTheme buildTextTheme(Color primary, Color secondary) {
    final base = GoogleFonts.manropeTextTheme();
    return TextTheme(
      displayLarge: base.displayLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.05,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: primary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        height: 1.1,
      ),
      displaySmall: base.displaySmall?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.15,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: secondary,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: primary,
        height: 1.6,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: secondary,
        height: 1.6,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: secondary,
        height: 1.5,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: secondary,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: secondary,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  static TextStyle mono({Color? color, double size = 14}) {
    return GoogleFonts.jetBrainsMono(
      color: color,
      fontSize: size,
      height: 1.5,
    );
  }
}
