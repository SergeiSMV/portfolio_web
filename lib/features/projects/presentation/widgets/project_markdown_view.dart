import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders the project body markdown with theme-aware styling and a
/// graceful fallback when referenced asset images are missing.
class ProjectMarkdownView extends StatelessWidget {
  const ProjectMarkdownView({super.key, required this.markdown});

  final String markdown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MarkdownBody(
      data: markdown,
      selectable: true,
      styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
        h1: theme.textTheme.headlineLarge,
        h2: theme.textTheme.headlineMedium,
        h3: theme.textTheme.headlineSmall,
        h4: theme.textTheme.titleLarge,
        p: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
        listBullet: theme.textTheme.bodyLarge,
        code: TextStyle(
          fontFamily: 'monospace',
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          color: theme.colorScheme.primary,
        ),
        codeblockDecoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        codeblockPadding: const EdgeInsets.all(16),
        blockquote: theme.textTheme.bodyLarge?.copyWith(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: theme.colorScheme.primary, width: 3),
          ),
        ),
        blockquotePadding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        a: TextStyle(
          color: theme.colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
      sizedImageBuilder: (config) {
        final uri = config.uri;
        final alt = config.alt;
        final label = (alt != null && alt.isNotEmpty) ? alt : uri.toString();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              uri.toString(),
              errorBuilder: (context, error, stack) =>
                  _MissingImage(label: label),
            ),
          ),
        );
      },
      onTapLink: (text, href, title) {
        if (href == null) return;
        if (href.startsWith('http')) {
          launchUrl(
            Uri.parse(href),
            mode: LaunchMode.externalApplication,
          );
        }
      },
    );
  }
}

class _MissingImage extends StatelessWidget {
  const _MissingImage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_outlined,
              size: 32,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
