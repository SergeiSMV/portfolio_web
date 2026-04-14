import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_cubit.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit()..loadTheme(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Sergei Semenov — Flutter Developer',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
