import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Declarative responsive switcher that renders different widget trees
/// per breakpoint using a [LayoutBuilder].
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
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
