import 'package:flutter/material.dart';

import 'open_sans_styles.dart';

/// Базовая типографика приложения (размеры, насыщенность, семейство шрифтов).
abstract class BaseTextStyles extends ThemeExtension<BaseTextStyles> {
  const BaseTextStyles({required this.openSansStyles});

  final OpenSansStyles openSansStyles;
}
