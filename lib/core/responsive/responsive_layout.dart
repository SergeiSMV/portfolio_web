import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Декларативный переключатель адаптивной верстки.
///
/// Рендерит разные деревья виджетов в зависимости от ширины контейнера,
/// используя [LayoutBuilder] и брейкпоинты из [Breakpoints].
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Виджет для маленьких экранов (`maxWidth < Breakpoints.mobile`).
  final Widget mobile;

  /// Виджет для планшетного диапазона.
  ///
  /// Если не задан, используется [desktop].
  final Widget? tablet;

  /// Виджет для широких экранов (`maxWidth >= Breakpoints.tablet`).
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    /// [LayoutBuilder] берет актуальную ширину родительских constraints,
    /// поэтому выбор layout зависит от реального доступного пространства.
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < Breakpoints.mobile) return mobile;
        if (constraints.maxWidth < Breakpoints.tablet) {
          return tablet ?? desktop;
        }
        return desktop;
      },
    );
  }
}
