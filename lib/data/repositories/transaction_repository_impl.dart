import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';
import '../models/transaction_model.dart';

/// SQLite-backed implementation of [TransactionRepository]; maps models to entities.
class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._dataSource);

  final TransactionLocalDataSource _dataSource;

  @override
  Future<List<TransactionEntity>> getAll() async {
    final models = await _dataSource.getAll();

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> add(TransactionEntity transaction) {
    return _dataSource.insert(TransactionModel.fromEntity(transaction));
  }

  @override
  Future<void> update(TransactionEntity transaction) {
    return _dataSource.update(TransactionModel.fromEntity(transaction));
  }

  @override
  Future<void> delete(int id) => _dataSource.delete(id);
}
