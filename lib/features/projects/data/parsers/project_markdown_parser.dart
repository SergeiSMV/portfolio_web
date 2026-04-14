import 'package:yaml/yaml.dart';

import '../models/project_model.dart';

/// Parses a project markdown file in the form:
///
/// ```
/// ---
/// <yaml frontmatter>
/// ---
///
/// # Markdown body...
/// ```
///
/// Throws [FormatException] if the frontmatter is missing or malformed.
class ProjectMarkdownParser {
  const ProjectMarkdownParser();

  ProjectModel parse(String raw) {
    final normalized = raw.replaceAll('\r\n', '\n');
    final lines = normalized.split('\n');

    if (lines.isEmpty || lines.first.trim() != '---') {
      throw const FormatException(
        'Project markdown must start with a --- frontmatter marker',
      );
    }

    var endIndex = -1;
    for (var i = 1; i < lines.length; i++) {
      if (lines[i].trim() == '---') {
        endIndex = i;
        break;
      }
    }
    if (endIndex == -1) {
      throw const FormatException(
        'Project markdown is missing the closing --- frontmatter marker',
      );
    }

    final yamlText = lines.sublist(1, endIndex).join('\n');
    final body = lines.sublist(endIndex + 1).join('\n').trimLeft();

    final doc = loadYaml(yamlText);
    if (doc is! Map) {
      throw const FormatException('Frontmatter must be a YAML mapping');
    }

    return ProjectModel.fromFrontmatter(frontmatter: doc, body: body);
  }
}
