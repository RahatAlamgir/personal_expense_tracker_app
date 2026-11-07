import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../state/theme_controller.dart';
import 'theme_sheet.dart';

/// Round header button that opens the appearance sheet.
class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final mode = context.watch<ThemeController>().mode;
    final icon = switch (mode) {
      AppThemeMode.system => Icons.brightness_auto_outlined,
      AppThemeMode.light => Icons.light_mode_outlined,
      AppThemeMode.dark => Icons.dark_mode_outlined,
    };

    return Semantics(
      button: true,
      label: AppStrings.themeTooltip,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => showThemeSheet(context),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: c.surface,
            shape: BoxShape.circle,
            border: Border.all(color: c.border),
          ),
          child: Icon(icon, size: 22, color: c.ink),
        ),
      ),
    );
  }
}
