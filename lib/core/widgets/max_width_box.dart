import 'package:flutter/material.dart';

import '../responsive/breakpoints.dart';

/// Center-aligned constrained box used to keep readable line length
/// on wide screens and provide responsive horizontal padding.
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: context.responsive(
                  mobile: 20,
                  tablet: 32,
                  desktop: 48,
                ),
              ),
          child: child,
        ),
      ),
    );
  }
}
