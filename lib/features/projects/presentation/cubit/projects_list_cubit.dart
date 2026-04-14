import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/project.dart';
import '../../domain/usecases/get_all_projects.dart';

// -----------------------------------------------------------------------------
// State
// -----------------------------------------------------------------------------

sealed class ProjectsListState extends Equatable {
  const ProjectsListState();

  @override
  List<Object?> get props => const [];
}

final class ProjectsListInitial extends ProjectsListState {
  const ProjectsListInitial();
}

final class ProjectsListLoading extends ProjectsListState {
  const ProjectsListLoading();
}

final class ProjectsListLoaded extends ProjectsListState {
  const ProjectsListLoaded({
    required this.projects,
    required this.activeTag,
  });

  final List<Project> projects;
  final String? activeTag;

  /// Returns projects filtered by [activeTag] (or all if no tag is active).
  List<Project> get filtered {
    if (activeTag == null) return projects;
    return projects.where((p) => p.tags.contains(activeTag)).toList();
  }

  /// All unique tags across loaded projects, for the filter bar.
  Set<String> get allTags =>
      projects.expand((p) => p.tags).toSet();

  ProjectsListLoaded copyWith({
    List<Project>? projects,
    String? activeTag,
    bool clearTag = false,
  }) {
    return ProjectsListLoaded(
      projects: projects ?? this.projects,
      activeTag: clearTag ? null : (activeTag ?? this.activeTag),
    );
  }

  @override
  List<Object?> get props => [projects, activeTag];
}

final class ProjectsListError extends ProjectsListState {
  const ProjectsListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// -----------------------------------------------------------------------------
// Cubit
// -----------------------------------------------------------------------------

class ProjectsListCubit extends Cubit<ProjectsListState> {
  ProjectsListCubit({required GetAllProjects getAllProjects})
      : _getAllProjects = getAllProjects,
        super(const ProjectsListInitial());

  final GetAllProjects _getAllProjects;

  Future<void> load() async {
    emit(const ProjectsListLoading());
    try {
      final projects = await _getAllProjects();
      emit(ProjectsListLoaded(projects: projects, activeTag: null));
    } catch (e) {
      emit(ProjectsListError(e.toString()));
    }
  }

  void toggleTag(String tag) {
    final current = state;
    if (current is! ProjectsListLoaded) return;
    if (current.activeTag == tag) {
      emit(current.copyWith(clearTag: true));
    } else {
      emit(current.copyWith(activeTag: tag));
    }
  }
}
