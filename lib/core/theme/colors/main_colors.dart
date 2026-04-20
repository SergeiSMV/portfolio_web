import 'package:flutter/material.dart';

/// Main semantic colors for app surfaces and accents.
abstract class MainColors {
  const MainColors({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.accent,
    required this.accentSecondary,
    required this.onPrimary,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color border;
  final Color accent;
  final Color accentSecondary;
  final Color onPrimary;
}
