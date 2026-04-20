import 'package:flutter/material.dart';

import '../theme/theme_context_extensions.dart';

/// Lightweight pill-shaped chip used for tags, stack items and filters.
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    this.onTap,
    this.selected = false,
    this.icon,
  });

  /// Текст внутри чипа.
  final String label;

  /// Обработчик нажатия; если `null`, чип используется как статичный элемент.
  final VoidCallback? onTap;

  /// Флаг активного/выбранного состояния.
  final bool selected;

  /// Опциональная иконка слева от текста.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Цвет текста/иконки зависит от выбора, чтобы активный чип был заметнее.
    final Color foreground = selected
        ? colors.mainColors.accent
        : colors.textColors.primary.withValues(alpha: 0.72);
    // Для выбранного состояния используем легкий tint от акцентного цвета.
    final Color background = selected
        ? colors.mainColors.accent.withValues(alpha: 0.12)
        : colors.mainColors.surfaceAlt;

    return Material(
      // Прозрачный Material нужен, чтобы корректно рендерился ripple от InkWell.
      color: colors.mainColors.background.withValues(alpha: 0),
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
                  ? colors.mainColors.accent.withValues(alpha: 0.45)
                  : colors.elementColors.divider,
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
                // Размер/вес берем из дизайн-системы, динамически меняем только цвет.
                style: context.textStyle.openSansStyles.mediumOpenSans12
                    .copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
