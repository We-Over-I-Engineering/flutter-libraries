import 'package:flutter/material.dart';

/// Custom painter that handles fill of the progress bar.
class TextFillPainter extends CustomPainter {
  final Color fillColor;
  final double progressValue;
  final int tiltValue;

  TextFillPainter({
    required this.fillColor,
    required this.progressValue,
    this.tiltValue = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = fillColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    double fillHeight = size.height - (progressValue * size.height);
    if (fillHeight < 0) {
      fillHeight = 0;
    }
    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, fillHeight)
      ..lineTo(
          0.0,
          (fillHeight + (tiltValue)) > size.height
              ? size.height
              : (fillHeight + tiltValue))
      ..lineTo(0.0, size.height)
      ..close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
