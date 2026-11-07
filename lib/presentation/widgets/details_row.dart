import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';

/// A label / value row inside the details card.
class DetailsRow extends StatelessWidget {
  const DetailsRow({super.key, required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: c.inkMuted),
          const SizedBox(width: 10),
          SizedBox(
            width: 84,
            child: Text(label, style: t.bodyMedium!.copyWith(color: c.inkMuted)),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: t.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
