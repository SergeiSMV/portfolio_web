import 'package:yaml/yaml.dart';

import '../../domain/entities/project.dart';

/// Data-layer extension of [Project] that knows how to build itself from a
/// parsed YAML frontmatter map plus the remaining markdown body.
class ProjectModel extends Project {
  const ProjectModel({
    required super.slug,
    required super.title,
    required super.role,
    required super.period,
    required super.summary,
    required super.tags,
    required super.stack,
    required super.platforms,
    required super.links,
    required super.body,
    super.client,
    super.cover,
    super.featured,
    super.order,
  });

  factory ProjectModel.fromFrontmatter({
    required Map<dynamic, dynamic> frontmatter,
    required String body,
  }) {
    List<String> stringList(dynamic value) {
      if (value == null) return const <String>[];
      if (value is YamlList) {
        return value.map((e) => e.toString()).toList();
      }
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return const <String>[];
    }

    final links = <ProjectLink>[];
    final rawLinks = frontmatter['links'];
    if (rawLinks is Map) {
      rawLinks.forEach((key, value) {
        links.add(ProjectLink(label: key.toString(), url: value.toString()));
      });
    }

    int parseOrder(dynamic value) {
      if (value is int) return value;
      return int.tryParse(value?.toString() ?? '') ?? 9999;
    }

    return ProjectModel(
      slug: frontmatter['slug']?.toString() ?? '',
      title: frontmatter['title']?.toString() ?? '',
      role: frontmatter['role']?.toString() ?? '',
      period: frontmatter['period']?.toString() ?? '',
      summary: frontmatter['summary']?.toString() ?? '',
      client: frontmatter['client']?.toString(),
      cover: frontmatter['cover']?.toString(),
      tags: stringList(frontmatter['tags']),
      stack: stringList(frontmatter['stack']),
      platforms: stringList(frontmatter['platforms']),
      links: links,
      featured: frontmatter['featured'] == true,
      order: parseOrder(frontmatter['order']),
      body: body,
    );
  }
}
