import 'dart:math';

import 'package:flutter/material.dart';

class BorderCirclePainter extends CustomPainter {
  Paint _paint;
  double _fraction;

  BorderCirclePainter(this._fraction) {
    _paint = Paint()
        ..color = Colors.grey[600]
        ..strokeWidth = 8.0
        ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(0.0, 0.0) & size;
    final startAngle = pi / 4;
    final sweepAngle = pi * 2 * 3 / 4 * _fraction;
    canvas.drawArc(rect, startAngle, sweepAngle, false, _paint);
  }

  @override
  bool shouldRepaint(BorderCirclePainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}