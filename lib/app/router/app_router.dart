import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_shell.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/projects/presentation/pages/project_detail_page.dart';
import '../../features/projects/presentation/pages/projects_list_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: false,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.projects,
            name: 'projects',
            pageBuilder: (context, state) => const NoTransitionPage<void>(
              child: ProjectsListPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.projectDetail,
            name: 'project-detail',
            pageBuilder: (context, state) {
              final slug = state.pathParameters['slug']!;
              return NoTransitionPage<void>(
                child: ProjectDetailPage(slug: slug),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('404', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 8),
            Text('Страница не найдена: ${state.uri.path}'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => GoRouter.of(context).go(AppRoutes.home),
              child: const Text('На главную'),
            ),
          ],
        ),
      ),
    ),
  );
}
