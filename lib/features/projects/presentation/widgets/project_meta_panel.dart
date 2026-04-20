import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/colors/base_colors.dart';
import '../../../../core/theme/theme_context_extensions.dart';
import '../../domain/entities/project.dart';

/// Side panel with structured project metadata displayed on the detail page.
class ProjectMetaPanel extends StatelessWidget {
  const ProjectMetaPanel({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.mainColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.elementColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row(context, colors, 'Роль', project.role),
          _row(context, colors, 'Период', project.period),
          if (project.client != null && project.client!.isNotEmpty)
            _row(context, colors, 'Клиент', project.client!),
          if (project.platforms.isNotEmpty)
            _row(context, colors, 'Платформы', project.platforms.join(', ')),
          const SizedBox(height: 8),
          _label(context, colors, 'Стек'),
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
                      color: colors.mainColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      s,
                      style: context.textStyle.openSansStyles
                          .mediumOpenSans11
                          .copyWith(color: context.colors.textColors.secondary),
                    ),
                  ),
                )
                .toList(),
          ),
          if (project.links.isNotEmpty) ...[
            const SizedBox(height: 24),
            _label(context, colors, 'Ссылки'),
            const SizedBox(height: 8),
            ...project.links.map((link) => _LinkRow(link: link)),
          ],
        ],
      ),
    );
  }

  Widget _row(BuildContext context, BaseColors colors, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(context, colors, label),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textStyle.openSansStyles.openSans14.copyWith(
              color: colors.textColors.primary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, BaseColors colors, String text) {
    return Text(
      text.toUpperCase(),
      style: context.textStyle.openSansStyles.semiBoldOpenSans11.copyWith(
        color: colors.textColors.primary.withValues(alpha: 0.55),
        letterSpacing: 1.5,
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.link});

  final ProjectLink link;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
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
                  ? colors.mainColors.accent
                  : colors.textColors.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '${link.label}: ${link.url}',
                style: context.textStyle.openSansStyles.mediumOpenSans12.copyWith(
                  color: link.isHttp
                      ? colors.mainColors.accent
                      : colors.textColors.primary.withValues(alpha: 0.5),
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
