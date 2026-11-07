import '../local/database_helper.dart';
import '../models/transaction_model.dart';

/// Raw SQLite access for the `transactions` table; no mapping to domain types.
class TransactionLocalDataSource {
  TransactionLocalDataSource(this._helper);

  final DatabaseHelper _helper;

  /// Reads all rows, newest date first (ties: highest id first).
  Future<List<TransactionModel>> getAll() async {
    final db = await _helper.database;
    final rows = await db.query(DatabaseHelper.tableName, orderBy: 'date DESC, id DESC');

    return rows.map(TransactionModel.fromMap).toList();
  }

  /// Inserts a row; SQLite assigns the AUTOINCREMENT id.
  Future<void> insert(TransactionModel model) async {
    final db = await _helper.database;
    await db.insert(DatabaseHelper.tableName, model.toMap());
  }

  /// Updates the row with the same id as [model].
  Future<void> update(TransactionModel model) async {
    final db = await _helper.database;
    await db.update(
      DatabaseHelper.tableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  /// Deletes the row with [id].
  Future<void> delete(int id) async {
    final db = await _helper.database;
    await db.delete(DatabaseHelper.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
