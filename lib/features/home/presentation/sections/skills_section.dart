import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/widgets/max_width_box.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/tag_chip.dart';

/// Grouped technical expertise. Data is static here, easy to externalize
/// into assets later if the catalog grows.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _groups = <(String, List<String>)>[
    (
      'Core',
      ['Flutter', 'Dart', 'Clean Architecture', 'Feature-first', 'DDD-lite'],
    ),
    (
      'State management',
      ['flutter_bloc', 'Cubit', 'Provider', 'Riverpod'],
    ),
    (
      'Data & persistence',
      ['Drift', 'Isar', 'Hive', 'SharedPreferences', 'SQLite'],
    ),
    (
      'Native / Platform',
      [
        'MethodChannel',
        'EventChannel',
        'Kotlin (Android BLE)',
        'Swift (iOS)',
        'Reactive BLE',
      ],
    ),
    (
      'DI & Tooling',
      ['get_it', 'injectable', 'build_runner', 'slang', 'flutter_gen'],
    ),
    (
      'Observability',
      ['Talker', 'talker_bloc_logger', 'Crashlytics', 'Sentry'],
    ),
    (
      'CI/CD',
      ['GitHub Actions', 'Fastlane', 'Codemagic'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(mobile: 56, tablet: 72, desktop: 100),
      ),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Stack',
              title: AppStrings.sectionSkills,
              subtitle: AppStrings.skillsSubtitle,
            ),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = context.responsive(
                  mobile: 1,
                  tablet: 2,
                  desktop: 2,
                );
                const spacing = 24.0;
                final itemWidth =
                    (constraints.maxWidth - spacing * (columns - 1)) / columns;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: _groups
                      .map(
                        (g) => SizedBox(
                          width: itemWidth,
                          child: _SkillGroup(title: g.$1, items: g.$2),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  const _SkillGroup({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((e) => TagChip(label: e)).toList(),
          ),
        ],
      ),
    );
  }
}
