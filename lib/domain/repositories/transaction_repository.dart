import '../entities/transaction_entity.dart';

/// Contract for storing transactions; the domain depends on this, never on SQLite.
abstract class TransactionRepository {
  /// Returns every stored transaction. Order is not guaranteed.
  Future<List<TransactionEntity>> getAll();

  /// Inserts a new transaction; the database assigns its id.
  Future<void> add(TransactionEntity transaction);

  /// Overwrites the stored transaction whose id matches [transaction].
  Future<void> update(TransactionEntity transaction);

  /// Deletes the transaction with [id]; does nothing if it does not exist.
  Future<void> delete(int id);
}
