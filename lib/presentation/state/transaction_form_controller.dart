import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_type.dart';
import 'transaction_controller.dart';

/// Form state shared by the Add and Edit screens.
class TransactionFormController extends ChangeNotifier {
  TransactionFormController({this.existing}) {
    final e = existing;
    title = TextEditingController(text: e?.title ?? '');
    amount = TextEditingController(text: e == null ? '' : e.amount.toStringAsFixed(2));
    _type = e?.type ?? TransactionType.expense;
    _category = e?.category;
    _date = e?.date ?? DateTime.now();
  }

  /// The transaction being edited, or null when adding a new one.
  final TransactionEntity? existing;
  final formKey = GlobalKey<FormState>();
  late final TextEditingController title;
  late final TextEditingController amount;

  late TransactionType _type;
  Category? _category;
  late DateTime _date;
  bool _saving = false;

  /// True when editing an existing transaction.
  bool get isEdit => existing != null;

  TransactionType get type => _type;

  Category? get category => _category;

  DateTime get date => _date;

  bool get isSaving => _saving;

  /// Switches Income / Expense and clears the category if it no longer fits the new type.
  void setType(TransactionType value) {
    _type = value;
    if (_category?.type != value) _category = null;
    notifyListeners();
  }

  void setCategory(Category? value) {
    _category = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  /// Title must not be empty or only spaces.
  String? validateTitle(String? value) {
    return (value == null || value.trim().isEmpty) ? AppStrings.titleRequired : null;
  }

  /// Amount must be a number greater than zero.
  String? validateAmount(String? value) {
    final n = double.tryParse((value ?? '').trim());

    return (n == null || n <= 0) ? AppStrings.amountInvalid : null;
  }

  /// A category must be selected.
  String? validateCategory(Category? value) {
    return value == null ? AppStrings.categoryRequired : null;
  }

  /// Returns true when the form was valid and the transaction was stored.
  Future<bool> save(TransactionController transactions) async {
    if (!formKey.currentState!.validate()) return false;
    _saving = true;
    notifyListeners();
    final parsed = double.parse(amount.text.trim());
    final current = existing;
    if (current == null) {
      await transactions.add(
        TransactionEntity(
          title: title.text.trim(),
          amount: parsed,
          type: _type,
          category: _category!,
          date: _date,
        ),
      );
    } else {
      await transactions.update(
        current.copyWith(
          title: title.text.trim(),
          amount: parsed,
          type: _type,
          category: _category,
          date: _date,
        ),
      );
    }
    _saving = false;

    return true;
  }

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }
}
