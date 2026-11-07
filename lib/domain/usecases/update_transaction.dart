import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

/// Saves changes to an existing transaction.
class UpdateTransaction {
  const UpdateTransaction(this._repository);

  final TransactionRepository _repository;

  Future<void> call(TransactionEntity transaction) => _repository.update(transaction);
}
