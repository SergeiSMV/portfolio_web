import '../entities/project.dart';
import '../repositories/project_repository.dart';

/// Use case: fetch a single project by its slug.
class GetProjectBySlug {
  const GetProjectBySlug(this._repository);

  final ProjectRepository _repository;

  Future<Project> call(String slug) => _repository.getProjectBySlug(slug);
}
