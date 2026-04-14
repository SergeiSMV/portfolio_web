import 'package:flutter/material.dart';

/// Lightweight pill-shaped chip used for tags, stack items and filters.
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    this.onTap,
    this.selected = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onTap;
  final bool selected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color foreground = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withValues(alpha: 0.72);
    final Color background = selected
        ? theme.colorScheme.primary.withValues(alpha: 0.12)
        : theme.colorScheme.surfaceContainerHighest;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary.withValues(alpha: 0.45)
                  : theme.colorScheme.outline,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: foreground),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
