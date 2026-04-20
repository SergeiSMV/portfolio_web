import 'package:flutter/material.dart';

import 'element_colors.dart';
import 'gradient_colors.dart';
import 'main_colors.dart';
import 'text_colors.dart';

/// App color system grouped by semantic buckets.
abstract class BaseColors extends ThemeExtension<BaseColors> {
  const BaseColors({
    required this.mainColors,
    required this.textColors,
    required this.gradientColors,
    required this.elementColors,
  });

  final MainColors mainColors;
  final TextColors textColors;
  final GradientColors gradientColors;
  final ElementColors elementColors;
}
