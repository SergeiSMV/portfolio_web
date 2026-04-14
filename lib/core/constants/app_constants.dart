/// Static paths and other build-time constants.
class AppConstants {
  AppConstants._();

  /// Manifest with the list of project slugs to load at runtime.
  static const String projectsIndexPath = 'assets/projects/index.json';

  /// Path to a project's markdown file by slug.
  ///
  /// Convention: `assets/projects/<slug>/<slug>.md`.
  static String projectMarkdownPath(String slug) =>
      'assets/projects/$slug/$slug.md';
}
