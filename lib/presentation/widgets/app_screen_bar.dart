import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';

/// App bar for flow screens: round back button plus a title.
PreferredSizeWidget buildScreenBar(BuildContext context, String title) {
  final c = context.colors;

  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 64,
    titleSpacing: 20,
    title: Row(
      children: [
        Semantics(
          button: true,
          label: AppStrings.back,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: c.surface,
                shape: BoxShape.circle,
                border: Border.all(color: c.border),
              ),
              child: Icon(Icons.chevron_left_rounded, size: 26, color: c.ink),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    ),
  );
}
