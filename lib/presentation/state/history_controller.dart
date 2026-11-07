import 'package:flutter/material.dart';

import '../../core/utils/date_formatter.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_type.dart';

/// Search text and filters for the History screen.
class HistoryController extends ChangeNotifier {
  /// Text in the search box; owned (and disposed) by this controller.
  final TextEditingController search = TextEditingController();

  TransactionType? _type;
  Category? _category;

  TransactionType? get type => _type;

  Category? get category => _category;

  /// True when a search or any filter is active.
  bool get isFiltering => search.text.trim().isNotEmpty || _type != null || _category != null;

  /// Called on every keystroke so the list re-filters.
  void onQueryChanged(String _) => notifyListeners();

  void clearSearch() {
    search.clear();
    notifyListeners();
  }

  /// Clears the type and category filters (the search text is kept).
  void showAll() {
    _type = null;
    _category = null;
    notifyListeners();
  }

  /// Selects [type]; selecting the active type again turns it off. Resets the category
  /// filter.
  void toggleType(TransactionType type) {
    _type = _type == type ? null : type;
    _category = null;
    notifyListeners();
  }

  /// Filters by [category]; null shows all categories.
  void selectCategory(Category? category) {
    _category = category;
    notifyListeners();
  }

  /// Clears the search text and every filter.
  void clearAll() {
    search.clear();
    _type = null;
    _category = null;
    notifyListeners();
  }

  /// Returns the transactions that match the search text and filters.
  List<TransactionEntity> apply(List<TransactionEntity> all) {
    final q = search.text.trim().toLowerCase();

    return all.where((t) {
      if (_type != null && t.type != _type) return false;
      if (_category != null && t.category != _category) return false;
      if (q.isEmpty) return true;

      return t.title.toLowerCase().contains(q) || t.category.label.toLowerCase().contains(q);
    }).toList();
  }

  /// Groups [items] by calendar day, keeping their order.
  Map<DateTime, List<TransactionEntity>> groupByDay(List<TransactionEntity> items) {
    final groups = <DateTime, List<TransactionEntity>>{};
    for (final tx in items) {
      groups.putIfAbsent(DateFormatter.dayOnly(tx.date), () => []).add(tx);
    }

    return groups;
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}
