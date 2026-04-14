import 'package:flutter/widgets.dart';

enum ScreenSize { mobile, tablet, desktop }

/// Global responsive breakpoints for the whole app.
class Breakpoints {
  Breakpoints._();

  /// Width below which layout switches to mobile form factor.
  static const double mobile = 600;

  /// Width below which layout switches to tablet form factor.
  static const double tablet = 1024;

  /// Maximum content width for desktop layouts — content above this value
  /// is centered and padded.
  static const double maxContentWidth = 1200;
}

extension ScreenSizeX on BuildContext {
  ScreenSize get screenSize {
    final width = MediaQuery.sizeOf(this).width;
    if (width < Breakpoints.mobile) return ScreenSize.mobile;
    if (width < Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;

  /// Pick a value for the current breakpoint. Tablet falls back to desktop
  /// when not specified.
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
