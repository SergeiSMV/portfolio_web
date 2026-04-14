import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/project.dart';

/// Side panel with structured project metadata displayed on the detail page.
class ProjectMetaPanel extends StatelessWidget {
  const ProjectMetaPanel({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(theme, 'Роль', project.role),
          _row(theme, 'Период', project.period),
          if (project.client != null && project.client!.isNotEmpty)
            _row(theme, 'Клиент', project.client!),
          if (project.platforms.isNotEmpty)
            _row(theme, 'Платформы', project.platforms.join(', ')),
          const SizedBox(height: 8),
          _label(theme, 'Стек'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.stack
                .map(
                  (s) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      s,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (project.links.isNotEmpty) ...[
            const SizedBox(height: 24),
            _label(theme, 'Ссылки'),
            const SizedBox(height: 8),
            ...project.links.map((link) => _LinkRow(link: link)),
          ],
        ],
      ),
    );
  }

  Widget _row(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(theme, label),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(ThemeData theme, String text) {
    return Text(
      text.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.link});

  final ProjectLink link;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: link.isHttp
            ? () => launchUrl(
                  Uri.parse(link.url),
                  mode: LaunchMode.externalApplication,
                )
            : null,
        borderRadius: BorderRadius.circular(6),
        child: Row(
          children: [
            Icon(
              link.isHttp ? Icons.north_east : Icons.link_off,
              size: 14,
              color: link.isHttp
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '${link.label}: ${link.url}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: link.isHttp
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
