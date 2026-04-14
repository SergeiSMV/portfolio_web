import 'package:flutter/material.dart';

import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/featured_projects_section.dart';
import '../sections/hero_section.dart';
import '../sections/skills_section.dart';
import '../widgets/plexus_viewport_background.dart';

/// Landing page composed of the main vertical sections.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(
          child: IgnorePointer(
            child: PlexusViewportBackground(),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: const [
              HeroSection(),
              AboutSection(),
              SkillsSection(),
              FeaturedProjectsSection(),
              ContactSection(),
            ],
          ),
        ),
      ],
    );
  }
}
