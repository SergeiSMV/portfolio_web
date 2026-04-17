/// Centralised route definitions. Use these constants instead of hard-coded
/// strings across the app.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String projects = '/projects';
  static const String projectDetail = '/projects/:slug';

  static String projectDetailPath(String slug) => '/projects/$slug';
}
