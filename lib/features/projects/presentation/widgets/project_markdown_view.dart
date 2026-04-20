import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme_context_extensions.dart';

/// Рендерит markdown-тело проекта.
///
/// Что делает этот виджет:
/// - отображает markdown через `MarkdownBody`;
/// - централизованно настраивает типографику/отступы через `MarkdownStyleSheet`;
/// - рендерит картинки из assets и показывает fallback, если файл не найден;
/// - открывает внешние ссылки (`http/https`) через системный браузер.
class ProjectMarkdownView extends StatelessWidget {
  const ProjectMarkdownView({
    super.key,
    required this.markdown,
    this.selectable = false,
  });

  /// Markdown-контент проекта (без frontmatter), который нужно отрендерить.
  final String markdown;

  /// Разрешает выделение и копирование текста на экране.
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;
    final textStyles = context.textStyle.openSansStyles;
    final textColors = colors.textColors;
    // `MarkdownBody` рендерит контент без собственного скролла
    // (скролл обычно задаётся родительским виджетом страницы).
    return MarkdownBody(
      // Исходный markdown-текст проекта (уже без YAML frontmatter).
      data: markdown,
      // Если true — текст можно выделять/копировать (удобно для desktop/web).
      selectable: selectable,
      styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
        // Стиль для markdown-заголовка `# ...`
        h1: textStyles.boldOpenSans32.copyWith(
          color: textColors.primary,
          letterSpacing: -0.5,
        ),
        // Стиль для markdown-заголовка `## ...`
        h2: textStyles.boldOpenSans28.copyWith(color: textColors.primary),
        // Стиль для markdown-заголовка `### ...`
        h3: textStyles.semiBoldOpenSans24.copyWith(color: textColors.primary),
        // Стиль для markdown-заголовка `#### ...`
        h4: textStyles.semiBoldOpenSans22.copyWith(color: textColors.primary),
        // Внешние отступы вокруг заголовка h1 (сверху/снизу).
        // h1Padding: const EdgeInsets.only(top: 32, bottom: 12),
        // Внешние отступы вокруг заголовка h2. (задачи, решение, результат и т.д.)
        h2Padding: const EdgeInsets.only(top: 32, bottom: 6),
        // Внешние отступы вокруг заголовка h3.
        // h3Padding: const EdgeInsets.only(top: 24, bottom: 12),
        // Внешние отступы вокруг заголовка h4.
        h4Padding: const EdgeInsets.only(top: 8, bottom: 0),

        // Нижний отступ после каждого параграфа.
        pPadding: const EdgeInsets.only(bottom: 12),
        // Величина отступа списка слева (вся группа list-item).
        listIndent: 24,
        // Отступ между маркером списка (bullet/number) и текстом.
        listBulletPadding: const EdgeInsets.only(right: 8),

        // Стиль обычного текста параграфа (включая межстрочный интервал).
        p: textStyles.openSans16.copyWith(color: textColors.primary),
        // Стиль маркера списка и текста list-item (если не переопределён отдельно).
        listBullet: textStyles.openSans16.copyWith(color: textColors.primary),

        // Стиль markdown-ссылки `[text](url)`.
        a: TextStyle(
          color: colors.mainColors.accent,
          decoration: TextDecoration.underline,
        ),
      ),

      // Кастомный рендер изображений из markdown.
      // Здесь перехватываем стандартное поведение `flutter_markdown`,
      // чтобы использовать `Image.asset` и единый UI (скругления/паддинги/fallback).
      sizedImageBuilder: (config) {
        final uri = config.uri;
        final alt = config.alt;
        // Текст для fallback: сначала alt, если пусто — путь до картинки.
        final label = (alt != null && alt.isNotEmpty) ? alt : uri.toString();
        final assetPath = uri.toString();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () => _openImagePreview(context, assetPath, label),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                // В markdown ожидаем относительные пути к ассетам
                // (например, assets/projects/...).
                assetPath,
                // Если картинка не загрузилась — показываем дружелюбный placeholder.
                errorBuilder: (context, error, stack) =>
                    _MissingImage(label: label),
              ),
            ),
          ),
        );
      },

      // Обработка клика по markdown-ссылке.
      onTapLink: (text, href, title) {
        if (href == null) return;
        // Разрешаем только внешние web-ссылки.
        // Внутренние/относительные href можно добавить позже отдельной логикой.
        if (href.startsWith('http')) {
          launchUrl(Uri.parse(href), mode: LaunchMode.externalApplication);
        }
      },
    );
  }

  void _openImagePreview(BuildContext context, String assetPath, String label) {
    final overlayControl = context.colors.elementColors.overlayControl;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stack) =>
                        _MissingImage(label: label),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton.filled(
                  iconSize: 20,
                  style: IconButton.styleFrom(
                    backgroundColor: overlayControl,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.close, size: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Fallback-виджет для отсутствующей/битой картинки из markdown.
class _MissingImage extends StatelessWidget {
  const _MissingImage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      // Фиксированная высота, чтобы макет страницы не "скакал"
      // при неуспешной загрузке изображений.
      height: 200,
      decoration: BoxDecoration(
        color: colors.mainColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.elementColors.divider),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_outlined,
              size: 32,
              color: colors.textColors.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: context.textStyle.openSansStyles.mediumOpenSans14
                    .copyWith(
                      fontSize: 11,
                      color: colors.textColors.primary.withValues(alpha: 0.6),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
