import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/graphs/graphs.dart';

/// Painter to create the data points and the line joining them.
class DataPointPainter extends CustomPainter {
  final List<LineProperties> dataPoints;
  final double max;

  DataPointPainter({
    required this.dataPoints,
    required this.max,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < dataPoints.length; i++) {
      if (dataPoints[i].filledGraph) {
        double strokeWidth = 2;
        Paint totalCircle = Paint()
          ..strokeWidth = strokeWidth
          ..color = dataPoints[i].dataPointColor
          ..style = PaintingStyle.stroke;
        double radius = dataPoints[i].dataPointSize;
        final Paint dataPlotter = Paint()
          ..color = dataPoints[i].fillColor
          ..style = PaintingStyle.fill;
        final Paint lineHighlighter = Paint()
          ..color = dataPoints[i].lineColor
          ..strokeWidth = dataPoints[i].lineWidth
          ..style = PaintingStyle.stroke;

        // Offset of the first data point
        Offset pointerOffset = Offset(
            size.width -
                (((size.width / dataPoints[i].values.length) *
                        dataPoints[i].values.length) -
                    (size.width / (dataPoints[i].values.length * 2))),
            (size.height -
                    (size.height / max) *
                        (dataPoints[i].values[0] < 0
                            ? 0
                            : dataPoints[i].values[0])) +
                2);

        Path path = Path();
        Path path2 = Path();
        path.moveTo(
            (((size.width / dataPoints[i].values.length) *
                    (dataPoints[i].values.length -
                        (dataPoints[i].values.length - 1))) -
                (size.width / (dataPoints[i].values.length * 2))),
            size.height);

        path.lineTo(pointerOffset.dx, pointerOffset.dy);
        path2.moveTo(pointerOffset.dx, pointerOffset.dy);
        if (dataPoints[i].showDataPoints) {
          canvas.drawCircle(pointerOffset, radius, totalCircle);
        }
        for (int j = 1; j < dataPoints[i].values.length; j++) {
          // Calculating the offset of the data points
          pointerOffset = Offset(
              size.width -
                  (((size.width / dataPoints[i].values.length) *
                          (dataPoints[i].values.length - j)) -
                      (size.width / (dataPoints[i].values.length * 2))),
              (size.height -
                      ((size.height / max) *
                          (dataPoints[i].values[j] < 0
                              ? 0
                              : dataPoints[i].values[j]))) +
                  2);

          path.lineTo(pointerOffset.dx, pointerOffset.dy);
          path2.lineTo(pointerOffset.dx, pointerOffset.dy);
          if (dataPoints[i].showDataPoints) {
            canvas.drawCircle(pointerOffset, radius, totalCircle);
          }
        }
        path.lineTo(
            (((size.width / dataPoints[i].values.length) *
                    (dataPoints[i].values.length)) -
                (size.width / (dataPoints[i].values.length * 2))),
            size.height);
        path.close();
        canvas.drawPath(path, dataPlotter);
        canvas.drawPath(path2, lineHighlighter);
      } else {
        double strokeWidth = 2;
        Paint totalCircle = Paint()
          ..strokeWidth = strokeWidth
          ..color = dataPoints[i].dataPointColor
          ..style = PaintingStyle.stroke;
        double radius = dataPoints[i].dataPointSize;
        final Paint dataPlotter = Paint()
          ..color = dataPoints[i].lineColor
          ..strokeWidth = dataPoints[i].lineWidth
          ..style = PaintingStyle.stroke;

        Offset pointerOffset = Offset(
            size.width -
                (((size.width / dataPoints[i].values.length) *
                        dataPoints[i].values.length) -
                    (size.width / (dataPoints[i].values.length * 2))),
            (size.height -
                    (size.height / max) *
                        (dataPoints[i].values[0] < 0
                            ? 0
                            : dataPoints[i].values[0])) +
                2);

        Path path = Path();

        path.moveTo(pointerOffset.dx, pointerOffset.dy);
        if (dataPoints[i].showDataPoints) {
          canvas.drawCircle(pointerOffset, radius, totalCircle);
        }
        for (int j = 1; j < dataPoints[i].values.length; j++) {
          // Calculating the offset of the data points.
          pointerOffset = Offset(
              size.width -
                  (((size.width / dataPoints[i].values.length) *
                          (dataPoints[i].values.length - j)) -
                      (size.width / (dataPoints[i].values.length * 2))),
              (size.height -
                      (size.height / max) *
                          (dataPoints[i].values[j] < 0
                              ? 0
                              : dataPoints[i].values[j])) +
                  2);

          path.lineTo(pointerOffset.dx, pointerOffset.dy);
          if (dataPoints[i].showDataPoints) {
            canvas.drawCircle(pointerOffset, radius, totalCircle);
          }
        }
        canvas.drawPath(path, dataPlotter);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
