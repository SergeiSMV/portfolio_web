import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/theme_context_extensions.dart';
import '../../../../core/widgets/max_width_box.dart';
import '../../../../core/widgets/tag_chip.dart';
import '../../domain/entities/project.dart';
import '../cubit/project_detail_cubit.dart';
import '../widgets/code_dust_background.dart';
import '../widgets/project_markdown_view.dart';
import '../widgets/project_meta_panel.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectDetailCubit(getProjectBySlug: sl())..load(slug),
      child: const _ProjectDetailView(),
    );
  }
}

class _ProjectDetailView extends StatelessWidget {
  const _ProjectDetailView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(
          child: IgnorePointer(child: CodeDustBackground()),
        ),
        BlocBuilder<ProjectDetailCubit, ProjectDetailState>(
          builder: (context, state) {
            return switch (state) {
              ProjectDetailInitial() || ProjectDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              ProjectDetailError(:final message) => Center(
                child: Text('Ошибка: $message'),
              ),
              ProjectDetailNotFound(:final slug) => _NotFound(slug: slug),
              ProjectDetailLoaded(:final project) => _Loaded(project: project),
            };
          },
        ),
      ],
    );
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound({required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Проект не найден: $slug'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => GoRouter.of(context).go(AppRoutes.projects),
            child: const Text(AppStrings.backToProjects),
          ),
        ],
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.responsive<TextStyle>(
      mobile: context.textStyle.openSansStyles.extraBoldOpenSans38,
      tablet: context.textStyle.openSansStyles.extraBoldOpenSans56,
      desktop: context.textStyle.openSansStyles.extraBoldOpenSans68,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: MaxWidthBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () => GoRouter.of(context).go(AppRoutes.projects),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text(AppStrings.backToProjects),
              ),
              const SizedBox(height: 24),
              Text(
                project.title,
                style: titleStyle.copyWith(
                  color: context.colors.textColors.primary,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  project.summary,
                  style: context.textStyle.openSansStyles.openSans18.copyWith(
                    color: context.colors.textColors.primary,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.tags.map((t) => TagChip(label: t)).toList(),
              ),
              const SizedBox(height: 48),
              if (context.isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RepaintBoundary(
                        child: ProjectMarkdownView(markdown: project.body),
                      ),
                    ),
                    const SizedBox(width: 48),
                    SizedBox(
                      width: 300,
                      child: ProjectMetaPanel(project: project),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProjectMetaPanel(project: project),
                    const SizedBox(height: 32),
                    RepaintBoundary(
                      child: ProjectMarkdownView(markdown: project.body),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
