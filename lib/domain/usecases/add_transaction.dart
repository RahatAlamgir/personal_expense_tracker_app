import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

/// Stores a new transaction.
class AddTransaction {
  const AddTransaction(this._repository);

  final TransactionRepository _repository;

  Future<void> call(TransactionEntity transaction) => _repository.add(transaction);
}
