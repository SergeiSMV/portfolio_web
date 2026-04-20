import 'package:flutter/material.dart';

/// Colors for UI elements and states.
abstract class ElementColors {
  const ElementColors({
    required this.icon,
    required this.divider,
    required this.overlayControl,
  });

  final Color icon;
  final Color divider;

  /// Фон контролов поверх оверлея (например, кнопка закрытия превью изображения).
  final Color overlayControl;
}
