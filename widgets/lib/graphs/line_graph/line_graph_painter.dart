import 'package:flutter/material.dart';

class DataPointPainter extends CustomPainter {
  final List<double> dataPoints;

  DataPointPainter({
    required this.dataPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dataPlotter = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(
        size.width -
            (((size.width / dataPoints.length) * dataPoints.length) -
                (size.width / (dataPoints.length * 2))),
        (size.height - (size.height / 150) * dataPoints[0]) - 10);
    for (int i = 1; i < dataPoints.length; i++) {
      path.lineTo(
          size.width -
              (((size.width / dataPoints.length) * (dataPoints.length - i)) -
                  (size.width / (dataPoints.length * 2))),
          (size.height - (size.height / 150) * dataPoints[i]) - 10);
    }
    canvas.drawPath(path, dataPlotter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
