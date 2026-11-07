import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Opens and owns the app's SQLite database.
class DatabaseHelper {
  static const databaseName = 'expense_tracker.db';
  static const tableName = 'transactions';
  static const _version = 1;

  Database? _database;

  /// The open database; opened on first use and then reused.
  Future<Database> get database async => _database ??= await _open();

  /// Opens (or creates) the database file in the platform databases folder.
  Future<Database> _open() async {
    final directory = await getDatabasesPath();

    return openDatabase(
      join(directory, databaseName),
      version: _version,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            category TEXT,
            type TEXT,
            date TEXT
          )
        ''');
      },
    );
  }
}
