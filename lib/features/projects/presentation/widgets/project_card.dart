import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/colors/base_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/theme_context_extensions.dart';
import '../../../../core/widgets/tag_chip.dart';
import '../../domain/entities/project.dart';

/// Hoverable card for a project. Navigates to detail page on tap.
class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final p = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: colors.mainColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hover
                ? colors.mainColors.accent.withValues(alpha: 0.55)
                : colors.elementColors.divider,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: colors.mainColors.accent.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: colors.mainColors.background.withValues(alpha: 0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () =>
                GoRouter.of(context).go(AppRoutes.projectDetailPath(p.slug)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CoverImage(cover: p.cover),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.period,
                        style: context.textStyle.openSansStyles
                            .semiBoldOpenSans11
                            .copyWith(
                              color: colors.mainColors.accent,
                              letterSpacing: 2,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.title,
                        style: context.textStyle.openSansStyles
                            .semiBoldOpenSans22
                            .copyWith(color: context.colors.textColors.primary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        p.summary,
                        style: context.textStyle.openSansStyles.openSans14.copyWith(
                          color: context.colors.textColors.secondary,
                          height: 1.6,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.tags
                            .take(4)
                            .map((t) => TagChip(label: t))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.cover});

  final String? cover;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: cover == null
            ? _placeholder(colors)
            : Image.asset(
                cover!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => _placeholder(colors),
              ),
      ),
    );
  }

  Widget _placeholder(BaseColors colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.mainColors.accent.withValues(alpha: 0.18),
            colors.mainColors.accentSecondary.withValues(alpha: 0.08),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.flutter_dash,
          size: 64,
          color: colors.mainColors.accent.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}
