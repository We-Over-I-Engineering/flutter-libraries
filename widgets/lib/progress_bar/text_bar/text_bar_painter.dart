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
      ..style = PaintingStyle
          .fill; // This will fill the inside of any shape created using the painter
    double fillHeight = size.height -
        (progressValue *
            size.height); // Multiplies the total height of the canvas with percentage of the height that is not needed and subtracts this value from the total height to get the needed height.
    if (fillHeight < 0) {
      fillHeight = 0;
    }
    final path = Path()
      // This piece of code defines points on the canvas that when joined make up the shape that needs to be filled.
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
