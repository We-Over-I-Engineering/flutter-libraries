import 'package:flutter/material.dart';

/// A custom painter for ractangle shaped container with tilted sides
/// This painter will be used as a child for the `ParallelogramButton`
class WOIParallelogramPainter extends CustomPainter {
  final double borderWidth;
  final Color buttonColor;
  final Color borderColor;
  final double tilt;

  WOIParallelogramPainter({
    this.borderWidth = 1,
    this.buttonColor = Colors.white,
    this.tilt = 10,
    this.borderColor = Colors.white,
  });
  @override
  void paint(Canvas canvas, Size size) {
    assert(tilt > -71 && tilt < 71,
        "The tilt value can't be more than 70 or less than -70");
    Paint paint_0 = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    Path path_0 = Path();
    path_0.moveTo(tilt, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width - tilt, size.height);
    path_0.lineTo(0, size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = Paint()
      ..color = buttonColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path_1 = Path();
    path_1.moveTo(tilt, 0);
    path_1.lineTo(size.width, 0);
    path_1.lineTo(size.width - tilt, size.height);
    path_1.lineTo(0, size.height);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
