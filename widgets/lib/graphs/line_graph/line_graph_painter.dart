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

    int index = 0;

    Path path = Path();
    path.moveTo(size.width - (((size.width / 7) * 7) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    index++;
    path.lineTo(size.width - (((size.width / 7) * 6) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    index++;
    path.lineTo(size.width - (((size.width / 7) * 5) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    index++;
    path.lineTo(size.width - (((size.width / 7) * 4) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    index++;
    path.lineTo(size.width - (((size.width / 7) * 3) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    index++;
    path.lineTo(size.width - (((size.width / 7) * 2) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    index++;
    path.lineTo(size.width - (((size.width / 7) * 1) - (size.width / 14)),
        size.height - (size.height / 150) * dataPoints[index]);
    canvas.drawPath(path, dataPlotter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
