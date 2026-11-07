import '../entities/app_theme_mode.dart';

/// Contract for persisting the user's appearance choice.
abstract class ThemePreferenceRepository {
  /// Returns the saved choice, or [AppThemeMode.system] when nothing is saved.
  Future<AppThemeMode> load();

  /// Remembers [mode] for the next launch.
  Future<void> save(AppThemeMode mode);
}
