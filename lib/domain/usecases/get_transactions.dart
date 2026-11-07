import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

/// Loads every stored transaction, newest first.
class GetTransactions {
  const GetTransactions(this._repository);

  final TransactionRepository _repository;

  /// Newest first (by date, then by creation order).
  Future<List<TransactionEntity>> call() async {
    final all = await _repository.getAll();

    return [...all]..sort((a, b) {
        final byDate = b.date.compareTo(a.date);

        return byDate != 0 ? byDate : (b.id ?? 0).compareTo(a.id ?? 0);
      });
  }
}
