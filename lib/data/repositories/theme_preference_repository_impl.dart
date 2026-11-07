import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/theme_preference_repository.dart';
import '../datasources/theme_local_data_source.dart';

/// Preferences-backed implementation of [ThemePreferenceRepository]; falls back to the
/// system theme.
class ThemePreferenceRepositoryImpl implements ThemePreferenceRepository {
  ThemePreferenceRepositoryImpl(this._dataSource);

  final ThemeLocalDataSource _dataSource;

  @override
  Future<AppThemeMode> load() async {
    final stored = _dataSource.read();

    return AppThemeMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  Future<void> save(AppThemeMode mode) => _dataSource.write(mode.name);
}
