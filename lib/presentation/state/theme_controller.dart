import 'package:flutter/material.dart';

import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/theme_preference_repository.dart';

/// The user's chosen appearance: follow the system, or force light or dark.
class ThemeController extends ChangeNotifier {
  ThemeController(this._repository);

  final ThemePreferenceRepository _repository;

  AppThemeMode _mode = AppThemeMode.system;

  AppThemeMode get mode => _mode;

  /// The value to hand to MaterialApp.themeMode.
  ThemeMode get themeMode => switch (_mode) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };

  /// Reads the saved choice; call once before the first frame.
  Future<void> load() async {
    _mode = await _repository.load();
    notifyListeners();
  }

  /// Applies [mode] immediately, then saves it.
  Future<void> setMode(AppThemeMode mode) async {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
    await _repository.save(mode);
  }
}
