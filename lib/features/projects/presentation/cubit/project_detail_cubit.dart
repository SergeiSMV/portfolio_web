import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/project.dart';
import '../../domain/usecases/get_project_by_slug.dart';

// -----------------------------------------------------------------------------
// State
// -----------------------------------------------------------------------------

sealed class ProjectDetailState extends Equatable {
  const ProjectDetailState();

  @override
  List<Object?> get props => const [];
}

final class ProjectDetailInitial extends ProjectDetailState {
  const ProjectDetailInitial();
}

final class ProjectDetailLoading extends ProjectDetailState {
  const ProjectDetailLoading();
}

final class ProjectDetailLoaded extends ProjectDetailState {
  const ProjectDetailLoaded(this.project);

  final Project project;

  @override
  List<Object?> get props => [project];
}

final class ProjectDetailNotFound extends ProjectDetailState {
  const ProjectDetailNotFound(this.slug);

  final String slug;

  @override
  List<Object?> get props => [slug];
}

final class ProjectDetailError extends ProjectDetailState {
  const ProjectDetailError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// -----------------------------------------------------------------------------
// Cubit
// -----------------------------------------------------------------------------

class ProjectDetailCubit extends Cubit<ProjectDetailState> {
  ProjectDetailCubit({required GetProjectBySlug getProjectBySlug})
      : _getProjectBySlug = getProjectBySlug,
        super(const ProjectDetailInitial());

  final GetProjectBySlug _getProjectBySlug;

  Future<void> load(String slug) async {
    emit(const ProjectDetailLoading());
    try {
      final project = await _getProjectBySlug(slug);
      emit(ProjectDetailLoaded(project));
    } on StateError {
      emit(ProjectDetailNotFound(slug));
    } catch (e) {
      emit(ProjectDetailError(e.toString()));
    }
  }
}
