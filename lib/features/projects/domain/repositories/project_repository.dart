import '../entities/project.dart';

/// Abstract access point for portfolio projects. Kept in the domain layer so
/// presentation code depends only on this interface, not on the asset-based
/// implementation.
abstract class ProjectRepository {
  /// Loads every project described in the manifest. Implementations may cache.
  Future<List<Project>> getAllProjects();

  /// Loads a single project by slug. Throws [StateError] if missing.
  Future<Project> getProjectBySlug(String slug);
}
