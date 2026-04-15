import 'package:flutter/widgets.dart';

/// Логические типы экранов, используемые в адаптивной верстке приложения.
///
/// Значение определяется по ширине экрана через [Breakpoints.mobile] и
/// [Breakpoints.tablet] в [ScreenSizeX.screenSize].
enum ScreenSize { mobile, tablet, desktop }

/// Глобальные брейкпоинты для всего приложения.
///
/// Цепочка зависимостей:
/// - [ScreenSizeX.screenSize] использует [mobile] и [tablet]
/// - [ScreenSizeX.isMobile]/[isTablet]/[isDesktop] зависят от [screenSize]
/// - [ScreenSizeX.responsive] выбирает значение на основе [screenSize]
class Breakpoints {
  Breakpoints._();

  /// Ширина, ниже которой используется мобильный тип экрана.
  ///
  /// Правило: `width < mobile` -> [ScreenSize.mobile].
  static const double mobile = 600;

  /// Верхняя граница для планшетного типа экрана.
  ///
  /// Правило: `mobile <= width < tablet` -> [ScreenSize.tablet].
  /// При `width >= tablet` используется [ScreenSize.desktop].
  static const double tablet = 1024;

  /// Максимальная ширина контента для desktop-раскладки — при превышении
  /// этого значения контент обычно центрируется и получает внешние отступы.
  static const double maxContentWidth = 1200;
}

extension ScreenSizeX on BuildContext {
  /// Вычисляет текущий логический тип экрана по ширине из [MediaQuery].
  ///
  /// Порядок проверок важен:
  /// 1) сначала порог mobile
  /// 2) затем порог tablet
  /// 3) иначе desktop
  ScreenSize get screenSize {
    final width = MediaQuery.sizeOf(this).width;
    if (width < Breakpoints.mobile) return ScreenSize.mobile;
    if (width < Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  /// Удобный флаг для проверки `screenSize == ScreenSize.mobile`.
  bool get isMobile => screenSize == ScreenSize.mobile;
  /// Удобный флаг для проверки `screenSize == ScreenSize.tablet`.
  bool get isTablet => screenSize == ScreenSize.tablet;
  /// Удобный флаг для проверки `screenSize == ScreenSize.desktop`.
  bool get isDesktop => screenSize == ScreenSize.desktop;

  /// Выбирает значение в зависимости от текущего типа экрана.
  ///
  /// Зависимости:
  /// - использует [screenSize], который вычисляется через
  ///   [Breakpoints.mobile]/[tablet].
  ///
  /// Поведение по умолчанию:
  /// - [mobile] обязателен для маленьких экранов
  /// - [desktop] обязателен и используется для tablet, если [tablet] не задан
  T responsive<T>({
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (screenSize) {
      case ScreenSize.mobile:
        return mobile;
      case ScreenSize.tablet:
        return tablet ?? desktop;
      case ScreenSize.desktop:
        return desktop;
    }
  }
}
