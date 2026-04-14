import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/widgets/max_width_box.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/project.dart';
import '../cubit/projects_list_cubit.dart';
import '../widgets/project_card.dart';
import '../widgets/project_tag_filter.dart';

class ProjectsListPage extends StatelessWidget {
  const ProjectsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectsListCubit(getAllProjects: sl())..load(),
      child: const _ProjectsListView(),
    );
  }
}

class _ProjectsListView extends StatelessWidget {
  const _ProjectsListView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: MaxWidthBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: 'Работы',
                title: AppStrings.sectionProjects,
                subtitle: AppStrings.projectsIntro,
              ),
              const SizedBox(height: 40),
              BlocBuilder<ProjectsListCubit, ProjectsListState>(
                builder: (context, state) {
                  return switch (state) {
                    ProjectsListInitial() || ProjectsListLoading() =>
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 64),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ProjectsListError(:final message) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 64),
                        child: Center(
                          child: Text('${AppStrings.loadingError}: $message'),
                        ),
                      ),
                    ProjectsListLoaded() => _LoadedBody(state: state),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.state});

  final ProjectsListLoaded state;

  @override
  Widget build(BuildContext context) {
    if (state.projects.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 64),
        child: Center(child: Text(AppStrings.noProjects)),
      );
    }

    final tags = state.allTags.toList()..sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectTagFilter(
          tags: tags,
          activeTag: state.activeTag,
          onTagTap: (t) => context.read<ProjectsListCubit>().toggleTag(t),
        ),
        const SizedBox(height: 32),
        _ProjectsGrid(projects: state.filtered),
      ],
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
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
