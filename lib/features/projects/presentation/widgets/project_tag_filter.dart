import 'package:flutter/material.dart';

import '../../../../core/widgets/tag_chip.dart';

/// Horizontal wrap of tag chips used to filter the projects list.
class ProjectTagFilter extends StatelessWidget {
  const ProjectTagFilter({
    super.key,
    required this.tags,
    required this.activeTag,
    required this.onTagTap,
  });

  final List<String> tags;
  final String? activeTag;
  final ValueChanged<String> onTagTap;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map(
            (t) => TagChip(
              label: t,
              selected: activeTag == t,
              onTap: () => onTagTap(t),
            ),
          )
          .toList(),
    );
  }
}
