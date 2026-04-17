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

  /// Разбирает сырой `.md` файл проекта на:
  /// - YAML frontmatter (между `---` и `---`) → поля модели
  /// - markdown body (после frontmatter) → контент для рендера
  ///
  /// Важно:
  /// - frontmatter обязателен (если его нет или он битый — кидаем [FormatException])
  /// - body возвращается “как есть” (без попыток парсинга markdown на этом уровне)
  ProjectModel parse(String raw) {
    // Нормализуем переводы строк, чтобы одинаково работать с файлами,
    // сохранёнными в Windows/macOS/Linux окружениях.
    final normalized = raw.replaceAll('\r\n', '\n');
    final lines = normalized.split('\n');

    // Первый маркер `---` обязателен: он означает начало YAML frontmatter.
    if (lines.isEmpty || lines.first.trim() != '---') {
      throw const FormatException(
        'Project markdown must start with a --- frontmatter marker',
      );
    }

    // Ищем закрывающий `---`. Всё между маркерами — YAML.
    // Всё после — markdown body.
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

    // YAML берём без маркеров, body — без лишних пустых строк слева
    // (чтобы markdown начинался сразу с контента).
    final yamlText = lines.sublist(1, endIndex).join('\n');
    final body = lines.sublist(endIndex + 1).join('\n').trimLeft();

    // Ожидаем, что frontmatter — это mapping (ключ → значение).
    final doc = loadYaml(yamlText);
    if (doc is! Map) {
      throw const FormatException('Frontmatter must be a YAML mapping');
    }

    return ProjectModel.fromFrontmatter(frontmatter: doc, body: body);
  }
}
