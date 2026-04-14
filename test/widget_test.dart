import 'package:flutter_test/flutter_test.dart';

import 'package:sergeismv_portfolio/features/projects/data/parsers/project_markdown_parser.dart';

void main() {
  const parser = ProjectMarkdownParser();

  group('ProjectMarkdownParser', () {
    test('parses frontmatter and body', () {
      const raw = '''---
slug: demo
title: Demo
role: Developer
period: 2024
summary: Short summary
tags: [mobile, flutter]
stack:
  - Flutter
  - Dart
platforms: [Android, iOS]
links:
  github: https://github.com/example
featured: true
order: 1
---

## Section

Body content.
''';

      final project = parser.parse(raw);

      expect(project.slug, 'demo');
      expect(project.title, 'Demo');
      expect(project.role, 'Developer');
      expect(project.period, '2024');
      expect(project.summary, 'Short summary');
      expect(project.tags, ['mobile', 'flutter']);
      expect(project.stack, ['Flutter', 'Dart']);
      expect(project.platforms, ['Android', 'iOS']);
      expect(project.featured, isTrue);
      expect(project.order, 1);
      expect(project.links.length, 1);
      expect(project.links.first.label, 'github');
      expect(project.links.first.url, 'https://github.com/example');
      expect(project.body.trim().startsWith('## Section'), isTrue);
    });

    test('throws on missing opening marker', () {
      expect(
        () => parser.parse('no frontmatter here'),
        throwsA(isA<FormatException>()),
      );
    });

    test('throws on missing closing marker', () {
      const raw = '''---
title: Broken
''';
      expect(
        () => parser.parse(raw),
        throwsA(isA<FormatException>()),
      );
    });

    test('handles windows line endings', () {
      const raw = '---\r\nslug: x\r\ntitle: X\r\nrole: r\r\nperiod: p\r\n'
          'summary: s\r\n---\r\nbody';
      final project = parser.parse(raw);
      expect(project.slug, 'x');
      expect(project.body, 'body');
    });

    test('uses defaults for missing optional fields', () {
      const raw = '''---
slug: minimal
title: Minimal
role: Dev
period: 2024
summary: ok
---

body
''';
      final project = parser.parse(raw);
      expect(project.tags, isEmpty);
      expect(project.stack, isEmpty);
      expect(project.platforms, isEmpty);
      expect(project.links, isEmpty);
      expect(project.featured, isFalse);
      expect(project.order, 9999);
    });
  });
}
