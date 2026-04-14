import 'package:equatable/equatable.dart';

/// Immutable representation of a portfolio project. Built from the YAML
/// frontmatter + markdown body of an `assets/projects/<slug>/<slug>.md` file.
class Project extends Equatable {
  const Project({
    required this.slug,
    required this.title,
    required this.role,
    required this.period,
    required this.summary,
    required this.tags,
    required this.stack,
    required this.platforms,
    required this.links,
    required this.body,
    this.client,
    this.cover,
    this.featured = false,
    this.order = 9999,
  });

  final String slug;
  final String title;
  final String role;
  final String period;
  final String summary;
  final String? client;
  final String? cover;

  /// High-level domain/type tags used for filtering (e.g. `mobile`, `ble`).
  final List<String> tags;

  /// Technical stack chips displayed on detail pages (e.g. `Flutter`, `Drift`).
  final List<String> stack;

  final List<String> platforms;
  final List<ProjectLink> links;
  final bool featured;
  final int order;

  /// Markdown body with frontmatter already stripped out.
  final String body;

  @override
  List<Object?> get props => [slug];
}

/// Named link (GitHub, case study, store page, etc.) attached to a project.
class ProjectLink extends Equatable {
  const ProjectLink({required this.label, required this.url});

  final String label;
  final String url;

  bool get isHttp => url.startsWith('http://') || url.startsWith('https://');

  @override
  List<Object?> get props => [label, url];
}
