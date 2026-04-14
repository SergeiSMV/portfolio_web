import '../entities/project.dart';
import '../repositories/project_repository.dart';

/// Use case: return all portfolio projects (sorted by the repository).
class GetAllProjects {
  const GetAllProjects(this._repository);

  final ProjectRepository _repository;

  Future<List<Project>> call() => _repository.getAllProjects();
}
