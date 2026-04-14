import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/constants/app_constants.dart';

/// Reads project files from the bundled `assets/` directory.
///
/// Flutter web cannot enumerate asset folders at runtime, so we rely on a
/// manifest (`assets/projects/index.json`) that lists the slugs.
class ProjectsAssetDataSource {
  const ProjectsAssetDataSource();

  /// Reads the project manifest and returns the ordered list of slugs.
  Future<List<String>> loadSlugs() async {
    final raw = await rootBundle.loadString(AppConstants.projectsIndexPath);
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['projects'] as List).cast<String>();
    return list;
  }

  /// Loads the raw markdown file for a given project slug.
  Future<String> loadMarkdown(String slug) {
    return rootBundle.loadString(AppConstants.projectMarkdownPath(slug));
  }
}
