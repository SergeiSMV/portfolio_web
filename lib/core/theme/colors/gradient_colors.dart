import 'package:flutter/material.dart';

/// Gradient colors used by decorative UI blocks.
abstract class GradientColors {
  const GradientColors({
    required this.heroOverlay,
  });

  final List<Color> heroOverlay;
}
