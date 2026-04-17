import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'router/app_router.dart';
import 'theme/colors/app_theme.dart';
import 'theme/colors/theme_cubit.dart';

/// Корневой виджет приложения.
///
/// Здесь поднимаем:
/// - состояние темы (light/dark);
/// - конфигурацию MaterialApp;
/// - роутер приложения.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      // Создаём cubit темы один раз на уровне всего приложения
      // и сразу загружаем сохранённый режим темы.
      create: (_) => ThemeCubit()..loadTheme(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Sergei Semenov — Flutter Developer',
            debugShowCheckedModeBanner: false,

            // Текущий режим темы берём из ThemeCubit.
            themeMode: themeMode,

            // Базовые light/dark ThemeData описаны централизованно в AppTheme.
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,

            // Навигация приложения работает через router-конфиг.
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
