import 'package:shared_preferences/shared_preferences.dart';

/// Reads and writes the saved appearance choice in shared preferences.
class ThemeLocalDataSource {
  ThemeLocalDataSource(this._prefs);

  static const _key = 'theme_mode_v1';

  final SharedPreferences _prefs;

  /// The stored mode name, or null if the user never chose one.
  String? read() => _prefs.getString(_key);

  /// Stores the mode name.
  Future<void> write(String value) => _prefs.setString(_key, value);
}
