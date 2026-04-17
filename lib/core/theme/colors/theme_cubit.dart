import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple cubit that tracks [ThemeMode] and persists it in [SharedPreferences].
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  static const _key = 'theme_mode';

  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(_key);
      if (value == 'light') {
        emit(ThemeMode.light);
      } else if (value == 'dark') {
        emit(ThemeMode.dark);
      }
    } catch (_) {
      null;
    }
  }

  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(next);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, next == ThemeMode.dark ? 'dark' : 'light');
    } catch (_) {}
  }
}
