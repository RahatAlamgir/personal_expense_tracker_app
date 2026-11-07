import 'package:flutter/material.dart';

/// Paints the navigation bar with a centred notch for the Add button.
class NotchedBarPainter extends CustomPainter {
  NotchedBarPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final m = w / 2;
    const r = 22.0;
    const top = 12.0;
    final path = Path()
      ..moveTo(r, top)
      ..lineTo(m - 51, top)
      ..cubicTo(m - 31, top, m - 29, 0, m, 0)
      ..cubicTo(m + 29, 0, m + 31, top, m + 51, top)
      ..lineTo(w - r, top)
      ..quadraticBezierTo(w, top, w, top + r)
      ..lineTo(w, h - r)
      ..quadraticBezierTo(w, h, w - r, h)
      ..lineTo(r, h)
      ..quadraticBezierTo(0, h, 0, h - r)
      ..lineTo(0, top + r)
      ..quadraticBezierTo(0, top, r, top)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(NotchedBarPainter old) => old.color != color;
}
