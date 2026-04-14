import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 2,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              label.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(title, style: theme.textTheme.displaySmall),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(subtitle!, style: theme.textTheme.bodyLarge),
          ),
        ],
      ],
    );
  }
}
