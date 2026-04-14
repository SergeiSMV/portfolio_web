import 'package:get_it/get_it.dart';

import '../../features/projects/data/datasources/projects_asset_data_source.dart';
import '../../features/projects/data/parsers/project_markdown_parser.dart';
import '../../features/projects/data/repositories/project_repository_impl.dart';
import '../../features/projects/domain/repositories/project_repository.dart';
import '../../features/projects/domain/usecases/get_all_projects.dart';
import '../../features/projects/domain/usecases/get_project_by_slug.dart';

/// Service locator. Keeps composition root in one place.
final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // --- Projects feature ------------------------------------------------------
  sl.registerLazySingleton<ProjectMarkdownParser>(
    () => const ProjectMarkdownParser(),
  );
  sl.registerLazySingleton<ProjectsAssetDataSource>(
    () => const ProjectsAssetDataSource(),
  );
  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(
      dataSource: sl<ProjectsAssetDataSource>(),
      parser: sl<ProjectMarkdownParser>(),
    ),
  );
  sl.registerLazySingleton<GetAllProjects>(
    () => GetAllProjects(sl<ProjectRepository>()),
  );
  sl.registerLazySingleton<GetProjectBySlug>(
    () => GetProjectBySlug(sl<ProjectRepository>()),
  );
}
