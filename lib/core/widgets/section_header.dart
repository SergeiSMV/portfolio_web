import 'package:flutter/material.dart';

import '../theme/theme_context_extensions.dart';

/// Uniform section heading with a small colored label line, a title and
/// optional subtitle. Used across Home and Projects pages.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  final String label;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 2,
              color: colors.mainColors.accent,
            ),
            const SizedBox(width: 12),
            Text(
              label.toUpperCase(),
              style: context.textStyle.openSansStyles.semiBoldOpenSans11
                  .copyWith(
                    color: colors.mainColors.accent,
                    letterSpacing: 2,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: context.textStyle.openSansStyles.boldOpenSans36.copyWith(
            color: context.colors.textColors.primary,
            letterSpacing: -0.5,
            height: 1.15,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              style: context.textStyle.openSansStyles.openSans16.copyWith(
                color: context.colors.textColors.primary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
