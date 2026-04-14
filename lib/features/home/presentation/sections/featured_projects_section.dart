import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/widgets/max_width_box.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../projects/domain/entities/project.dart';
import '../../../projects/presentation/cubit/projects_list_cubit.dart';
import '../../../projects/presentation/widgets/project_card.dart';

/// Home preview of featured projects. Grabs a slice from the same cubit
/// used on the dedicated list page.
class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectsListCubit(getAllProjects: sl())..load(),
      child: const _FeaturedBody(),
    );
  }
}

class _FeaturedBody extends StatelessWidget {
  const _FeaturedBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(mobile: 56, tablet: 72, desktop: 100),
      ),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Work',
              title: AppStrings.sectionProjects,
              subtitle: AppStrings.projectsIntro,
            ),
            const SizedBox(height: 40),
            BlocBuilder<ProjectsListCubit, ProjectsListState>(
              builder: (context, state) {
                return switch (state) {
                  ProjectsListInitial() || ProjectsListLoading() =>
                    const SizedBox(
                      height: 160,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ProjectsListError() =>
                    const Text(AppStrings.loadingError),
                  ProjectsListLoaded(:final projects) =>
                    _Grid(projects: _pickFeatured(projects)),
                };
              },
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () =>
                    GoRouter.of(context).go(AppRoutes.projects),
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text(AppStrings.seeAllProjects),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Project> _pickFeatured(List<Project> all) {
    final featured = all.where((p) => p.featured).toList();
    final pool = featured.isEmpty ? all : featured;
    return pool.take(3).toList();
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.projects});
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Text(AppStrings.noProjects);
    }
    final columns = context.responsive(mobile: 1, tablet: 2, desktop: 3);
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 24.0;
        final safeColumns =
            projects.length < columns ? projects.length : columns;
        if (safeColumns == 0) return const SizedBox.shrink();
        final itemWidth =
            (constraints.maxWidth - spacing * (safeColumns - 1)) / safeColumns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: projects
              .map(
                (p) => SizedBox(
                  width: itemWidth,
                  child: ProjectCard(project: p),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
