import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/datasources/theme_local_data_source.dart';
import 'data/datasources/transaction_local_data_source.dart';
import 'data/local/database_helper.dart';
import 'data/repositories/theme_preference_repository_impl.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'presentation/state/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(
    ThemePreferenceRepositoryImpl(ThemeLocalDataSource(prefs)),
  );
  await themeController.load();
  final repository = TransactionRepositoryImpl(
    TransactionLocalDataSource(DatabaseHelper()),
  );

  runApp(
    ExpenseTrackerApp(repository: repository, themeController: themeController),
  );
}
