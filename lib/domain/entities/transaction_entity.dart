import 'category.dart';
import 'transaction_type.dart';

/// A single income or expense record, as the rest of the app sees it.
class TransactionEntity {
  const TransactionEntity({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  /// Null until the database assigns one on insert.
  final int? id;
  final String title;
  final double amount;
  final TransactionType type;
  final Category category;
  final DateTime date;

  TransactionEntity copyWith({
    String? title,
    double? amount,
    TransactionType? type,
    Category? category,
    DateTime? date,
  }) {
    return TransactionEntity(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }
}
