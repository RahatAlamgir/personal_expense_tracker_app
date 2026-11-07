import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';

/// Success confirmation shown above the bottom navigation.
void showSuccessSnackBar(BuildContext context, String message) {
  final c = context.colors;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(color: c.income, shape: BoxShape.circle),
              child: Icon(Icons.check_rounded, size: 16, color: c.bg),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
}
