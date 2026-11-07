import '../../domain/entities/category.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_type.dart';

/// Row shape of the `transactions` table.
class TransactionModel {
  const TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  final int? id;
  final String title;
  final double amount;
  final String type;
  final String category;
  final String date;

  /// Builds a row from a domain entity. Enums are stored by name, dates as ISO-8601 text.
  factory TransactionModel.fromEntity(TransactionEntity e) {
    return TransactionModel(
      id: e.id,
      title: e.title,
      amount: e.amount,
      type: e.type.name,
      category: e.category.name,
      date: e.date.toIso8601String(),
    );
  }

  /// Builds a model from a database row.
  factory TransactionModel.fromMap(Map<String, Object?> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      type: map['type'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
    );
  }

  /// `id` is left out when null so SQLite assigns the next AUTOINCREMENT value.
  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'date': date,
    };
  }

  /// Converts to the domain entity; unknown categories fall back to "Other".
  TransactionEntity toEntity() {
    final txType = TransactionType.values.byName(type);

    return TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      type: txType,
      category: Category.values.firstWhere(
        (c) => c.name == category,
        orElse: () => txType.isIncome ? Category.otherIncome : Category.otherExpense,
      ),
      date: DateTime.parse(date),
    );
  }
}
