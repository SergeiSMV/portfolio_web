import 'package:flutter/material.dart';

import 'colors/app_colors.dart';
import 'colors/base_colors.dart';
import 'text_styles/app_text_styles.dart';

extension ThemeContextExtensions on BuildContext {
  /// Доступ к типографике: `context.textStyle.openSansStyles.openSans16`.
  AppTextStyles get textStyle =>
      Theme.of(this).extension<AppTextStyles>() ?? const AppTextStyles();

  /// Доступ к цветам: `context.colors.textColors.grey`.
  BaseColors get colors => Theme.of(this).extension<BaseColors>() ?? const AppColors.light();
}
