import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/projects_asset_data_source.dart';
import '../parsers/project_markdown_parser.dart';

/// Asset-backed implementation of [ProjectRepository].
///
/// Loads the list of project slugs from a JSON manifest, parses each
/// `.md` file and caches the result for the lifetime of the app.
class ProjectRepositoryImpl implements ProjectRepository {
  ProjectRepositoryImpl({
    required ProjectsAssetDataSource dataSource,
    required ProjectMarkdownParser parser,
  })  : _dataSource = dataSource,
        _parser = parser;

  final ProjectsAssetDataSource _dataSource;
  final ProjectMarkdownParser _parser;

  List<Project>? _cache;

  @override
  Future<List<Project>> getAllProjects() async {
    if (_cache != null) return _cache!;

    final slugs = await _dataSource.loadSlugs();
    final projects = <Project>[];

    for (final slug in slugs) {
      try {
        final raw = await _dataSource.loadMarkdown(slug);
        projects.add(_parser.parse(raw));
      } catch (_) {
        // Skip broken entries so one bad file doesn't nuke the whole list.
        // In a larger app we'd log this through Talker or similar.
        continue;
      }
    }

    projects.sort((a, b) {
      final byOrder = a.order.compareTo(b.order);
      if (byOrder != 0) return byOrder;
      return a.title.compareTo(b.title);
    });

    _cache = projects;
    return projects;
  }

  @override
  Future<Project> getProjectBySlug(String slug) async {
    final all = await getAllProjects();
    return all.firstWhere(
      (p) => p.slug == slug,
      orElse: () => throw StateError('Project "$slug" not found'),
    );
  }
}
