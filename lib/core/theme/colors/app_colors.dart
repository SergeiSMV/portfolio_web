import 'package:flutter/material.dart';

import 'base_colors.dart';
import 'element_colors.dart';
import 'gradient_colors.dart';
import 'main_colors.dart';
import 'text_colors.dart';

final class AppColors extends BaseColors {
  const AppColors.dark()
    : super(
        mainColors: const _DarkMainColors(),
        textColors: const _DarkTextColors(),
        gradientColors: const _DarkGradientColors(),
        elementColors: const _DarkElementColors(),
      );

  const AppColors.light()
    : super(
        mainColors: const _LightMainColors(),
        textColors: const _LightTextColors(),
        gradientColors: const _LightGradientColors(),
        elementColors: const _LightElementColors(),
      );

  @override
  ThemeExtension<BaseColors> copyWith() => this;

  @override
  ThemeExtension<BaseColors> lerp(
    covariant ThemeExtension<BaseColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return t < 0.5 ? this : other;
  }
}

final class _DarkMainColors extends MainColors {
  const _DarkMainColors()
    : super(
        accent: const Color(0xFF5B8DEF),
        accentSecondary: const Color(0xFF22C55E),
        background: const Color(0xFF0E0F13),
        surface: const Color(0xFF16181F),
        surfaceAlt: const Color(0xFF1E2128),
        border: const Color(0xFF2A2E38),
        onPrimary: Colors.white,
      );
}

final class _LightMainColors extends MainColors {
  const _LightMainColors()
    : super(
        accent: const Color(0xFF5B8DEF),
        accentSecondary: const Color(0xFF22C55E),
        background: const Color(0xFFF7F7F8),
        surface: const Color(0xFFFFFFFF),
        surfaceAlt: const Color(0xFFF0F1F5),
        border: const Color(0xFFE2E4EA),
        onPrimary: Colors.white,
      );
}

final class _DarkTextColors extends TextColors {
  const _DarkTextColors()
    : super(
        primary: const Color(0xFFF7F7F8),
        secondary: const Color(0xFFA1A5B3),
        grey: const Color(0xFFA1A5B3),
      );
}

final class _LightTextColors extends TextColors {
  const _LightTextColors()
    : super(
        primary: const Color(0xFF0E0F13),
        secondary: const Color(0xFF4A4F5C),
        grey: const Color(0xFF4A4F5C),
      );
}

final class _DarkGradientColors extends GradientColors {
  const _DarkGradientColors()
    : super(
        heroOverlay: const [
          Color(0xCC0E0F13),
          Color(0x990E0F13),
          Colors.transparent,
        ],
      );
}

final class _LightGradientColors extends GradientColors {
  const _LightGradientColors()
    : super(
        heroOverlay: const [
          Color(0xCCF7F7F8),
          Color(0x99F7F7F8),
          Colors.transparent,
        ],
      );
}

final class _DarkElementColors extends ElementColors {
  const _DarkElementColors()
    : super(
        icon: const Color(0xFFF7F7F8),
        divider: const Color(0xFF2A2E38),
        overlayControl: const Color(0xFF2B2B2B),
      );
}

final class _LightElementColors extends ElementColors {
  const _LightElementColors()
    : super(
        icon: const Color(0xFF0E0F13),
        divider: const Color(0xFFE2E4EA),
        overlayControl: const Color(0xFF2B2B2B),
      );
}
