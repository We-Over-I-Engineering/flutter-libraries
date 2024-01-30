import 'package:flutter/material.dart';

class DataPointPainter extends CustomPainter {
  final List<double> dataPoints;
  final double max;
  final bool isFilled;
  final Color lineColor;
  final Color fillColor;
  final Color dataPointColor;
  final double lineWidth;
  final double dataPointSize;

  DataPointPainter({
    required this.dataPoints,
    required this.max,
    required this.isFilled,
    this.lineColor = Colors.blue,
    this.fillColor = Colors.lightBlue,
    this.dataPointColor = const Color(0xFF8989BE),
    this.lineWidth = 1,
    this.dataPointSize = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isFilled) {
      double strokeWidth = 2;
      Paint totalCircle = Paint()
        ..strokeWidth = strokeWidth
        ..color = dataPointColor
        ..style = PaintingStyle.stroke;
      double radius = dataPointSize;
      final Paint dataPlotter = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;
      final Paint lineHighlighter = Paint()
        ..color = lineColor
        ..strokeWidth = lineWidth
        ..style = PaintingStyle.stroke;

      Offset pointerOffset = Offset(
          size.width -
              (((size.width / dataPoints.length) * dataPoints.length) -
                  (size.width / (dataPoints.length * 2))),
          size.height -
              (size.height / max) * (dataPoints[0] < 0 ? 0 : dataPoints[0]));

      Path path = Path();
      Path path2 = Path();
      path.moveTo(
          (((size.width / dataPoints.length) *
                  (dataPoints.length - (dataPoints.length - 1))) -
              (size.width / (dataPoints.length * 2))),
          size.height);

      path.lineTo(pointerOffset.dx, pointerOffset.dy);
      path2.moveTo(pointerOffset.dx, pointerOffset.dy);
      canvas.drawCircle(pointerOffset, radius, totalCircle);
      for (int i = 1; i < dataPoints.length; i++) {
        // Calculating the offset
        pointerOffset = Offset(
            size.width -
                (((size.width / dataPoints.length) * (dataPoints.length - i)) -
                    (size.width / (dataPoints.length * 2))),
            size.height -
                (size.height / max) * (dataPoints[i] < 0 ? 0 : dataPoints[i]));

        path.lineTo(pointerOffset.dx, pointerOffset.dy);
        path2.lineTo(pointerOffset.dx, pointerOffset.dy);
        canvas.drawCircle(pointerOffset, radius, totalCircle);
      }
      path.lineTo(
          (((size.width / dataPoints.length) * (dataPoints.length)) -
              (size.width / (dataPoints.length * 2))),
          size.height);
      path.close();
      canvas.drawPath(path, dataPlotter);
      canvas.drawPath(path2, lineHighlighter);
    } else {
      double strokeWidth = 2;
      Paint totalCircle = Paint()
        ..strokeWidth = strokeWidth
        ..color = dataPointColor
        ..style = PaintingStyle.stroke;
      double radius = dataPointSize;
      final Paint dataPlotter = Paint()
        ..color = lineColor
        ..strokeWidth = lineWidth
        ..style = PaintingStyle.stroke;

      Offset pointerOffset = Offset(
          size.width -
              (((size.width / dataPoints.length) * dataPoints.length) -
                  (size.width / (dataPoints.length * 2))),
          (size.height -
              (size.height / max) * (dataPoints[0] < 0 ? 0 : dataPoints[0]) +
              2));

      Path path = Path();

      path.moveTo(pointerOffset.dx, pointerOffset.dy);
      canvas.drawCircle(pointerOffset, radius, totalCircle);
      for (int i = 1; i < dataPoints.length; i++) {
        // Calculating the offset
        pointerOffset = Offset(
            size.width -
                (((size.width / dataPoints.length) * (dataPoints.length - i)) -
                    (size.width / (dataPoints.length * 2))),
            (size.height -
                (size.height / max) * (dataPoints[i] < 0 ? 0 : dataPoints[i]) +
                2));

        path.lineTo(pointerOffset.dx, pointerOffset.dy);
        canvas.drawCircle(pointerOffset, radius, totalCircle);
      }
      canvas.drawPath(path, dataPlotter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
