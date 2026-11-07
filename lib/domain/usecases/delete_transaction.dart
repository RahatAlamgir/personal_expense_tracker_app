import '../repositories/transaction_repository.dart';

/// Removes a transaction by id.
class DeleteTransaction {
  const DeleteTransaction(this._repository);

  final TransactionRepository _repository;

  Future<void> call(int id) => _repository.delete(id);
}
