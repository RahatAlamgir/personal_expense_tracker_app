import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../state/theme_controller.dart';
import 'sheet_option.dart';

/// Bottom sheet for choosing System, Light or Dark appearance.
Future<void> showThemeSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      final theme = sheetContext.read<ThemeController>();

      Widget option(IconData icon, String label, AppThemeMode mode) {
        return SheetOption(
          icon: icon,
          label: label,
          selected: theme.mode == mode,
          onTap: () {
            theme.setMode(mode);
            Navigator.pop(sheetContext);
          },
        );
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 0, AppSpacing.s4, AppSpacing.s4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, AppSpacing.s2),
                child: Text(
                  AppStrings.themeTitle,
                  style: Theme.of(sheetContext).textTheme.titleSmall,
                ),
              ),
              option(Icons.brightness_auto_outlined, AppStrings.themeSystem, AppThemeMode.system),
              option(Icons.light_mode_outlined, AppStrings.themeLight, AppThemeMode.light),
              option(Icons.dark_mode_outlined, AppStrings.themeDark, AppThemeMode.dark),
            ],
          ),
        ),
      );
    },
  );
}
