import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_formatter.dart';
import '../state/transaction_controller.dart';
import '../state/transaction_form_controller.dart';
import '../widgets/amount_field.dart';
import '../widgets/app_button.dart';
import '../widgets/app_screen_bar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/category_dropdown_field.dart';
import '../widgets/picker_field.dart';
import '../widgets/success_snack_bar.dart';
import '../widgets/type_toggle.dart';

/// Add form, or the Edit form when the provided controller has an existing transaction.
class AddEditTransactionScreen extends StatelessWidget {
  const AddEditTransactionScreen({super.key});

  /// Shows the date picker. Future dates are not selectable.
  Future<void> _pickDate(BuildContext context, TransactionFormController form) async {
    final today = DateFormatter.dayOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: form.date.isAfter(today) ? today : form.date,
      firstDate: DateTime(2000),
      lastDate: today,
    );
    if (picked != null) form.setDate(picked);
  }

  /// Saves the form, shows a success message and closes the screen.
  Future<void> _save(BuildContext context, TransactionFormController form) async {
    final saved = await form.save(context.read<TransactionController>());
    if (!saved || !context.mounted) return;
    showSuccessSnackBar(context, form.isEdit ? AppStrings.updated : AppStrings.added);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final form = context.watch<TransactionFormController>();
    final c = context.colors;

    return Scaffold(
      appBar: buildScreenBar(
        context,
        form.isEdit ? AppStrings.editTitle : AppStrings.addTitle,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.s2,
            AppSpacing.screen,
            AppSpacing.s6,
          ),
          child: Form(
            key: form.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.requiredMark,
                        style: TextStyle(color: c.expense, fontWeight: FontWeight.w800),
                      ),
                      const TextSpan(text: AppStrings.requiredLegend),
                    ],
                  ),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: c.inkMuted),
                ),
                const SizedBox(height: AppSpacing.s3),
                TypeToggle(value: form.type, onChanged: form.setType),
                const SizedBox(height: AppSpacing.s4),
                AmountField(
                  controller: form.amount,
                  textInputAction: TextInputAction.next,
                  validator: form.validateAmount,
                ),
                const SizedBox(height: AppSpacing.s4),
                AppTextField(
                  label: AppStrings.titleLabel,
                  controller: form.title,
                  hint: AppStrings.titleHint,
                  icon: Icons.edit_outlined,
                  maxLength: 80,
                  textInputAction: TextInputAction.done,
                  validator: form.validateTitle,
                ),
                const SizedBox(height: AppSpacing.s4),
                CategoryDropdownField(
                  type: form.type,
                  value: form.category,
                  onChanged: form.setCategory,
                  validator: form.validateCategory,
                ),
                const SizedBox(height: AppSpacing.s4),
                PickerField<DateTime>(
                  label: AppStrings.dateLabel,
                  icon: Icons.calendar_today_outlined,
                  value: form.date,
                  valueLabel: DateFormatter.full(form.date),
                  placeholder: AppStrings.datePlaceholder,
                  onTap: () => _pickDate(context, form),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screen, 12, AppSpacing.screen, 16),
          child: AppButton(
            label: form.isEdit ? AppStrings.updateButton : AppStrings.saveButton,
            icon: Icons.check_rounded,
            onPressed: form.isSaving ? null : () => _save(context, form),
          ),
        ),
      ),
    );
  }
}
