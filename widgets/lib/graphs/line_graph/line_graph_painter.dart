import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/graphs/line_graph/data_line_properties.dart';

/// Painter to create the data points and the line joining them.
class DataPointPainter extends CustomPainter {
  final List<LineProperties> dataPoints;
  final double max;
  final double topSpacing;

  DataPointPainter({
    required this.dataPoints,
    required this.max,
    required this.topSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 2;
    Paint totalCircle = Paint();
    double radius;
    Paint dataPlotter = Paint();
    Paint lineHighlighter = Paint();
    Offset pointerOffset;
    Path path = Path();
    Path path2 = Path();
    double singleUnitOfWidth;
    int totalNumberOfDataPoints;

    for (int i = 0; i < dataPoints.length; i++) {
      totalNumberOfDataPoints = dataPoints[i].values.length;
      singleUnitOfWidth = size.width / totalNumberOfDataPoints;

      if (dataPoints[i].filledGraph) {
        totalCircle
          ..strokeWidth = strokeWidth
          ..color = dataPoints[i].dataPointColor
          ..style = PaintingStyle.stroke;
        radius = dataPoints[i].dataPointSize;
        dataPlotter
          ..color = dataPoints[i].fillColor
          ..style = PaintingStyle.fill;
        lineHighlighter
          ..color = dataPoints[i].lineColor
          ..strokeWidth = dataPoints[i].lineWidth
          ..style = PaintingStyle.stroke;

        // Offset of the first data point
        pointerOffset = Offset(
            size.width -
                ((singleUnitOfWidth * totalNumberOfDataPoints) -
                    (size.width / (totalNumberOfDataPoints * 2))),
            ((size.height -
                        (size.height / max) *
                            (dataPoints[i].values[0] < 0
                                ? 0
                                : dataPoints[i].values[0])) +
                    2) -
                (topSpacing / 2));

        path.moveTo(
            ((singleUnitOfWidth *
                    (totalNumberOfDataPoints - (totalNumberOfDataPoints - 1))) -
                (size.width / (totalNumberOfDataPoints * 2))),
            size.height - (topSpacing / 2));

        path.lineTo(pointerOffset.dx, pointerOffset.dy);
        path2.moveTo(pointerOffset.dx, pointerOffset.dy);
        if (dataPoints[i].showDataPoints) {
          canvas.drawCircle(pointerOffset, radius, totalCircle);
        }
        for (int j = 1; j < dataPoints[i].values.length; j++) {
          // Calculating the offset of the data points
          pointerOffset = Offset(
              size.width -
                  ((singleUnitOfWidth * (totalNumberOfDataPoints - j)) -
                      (size.width / (totalNumberOfDataPoints * 2))),
              ((size.height -
                          ((size.height / max) *
                              (dataPoints[i].values[j] < 0
                                  ? 0
                                  : dataPoints[i].values[j]))) +
                      2) -
                  (topSpacing / 2));

          path.lineTo(pointerOffset.dx, pointerOffset.dy);
          path2.lineTo(pointerOffset.dx, pointerOffset.dy);
          if (dataPoints[i].showDataPoints) {
            canvas.drawCircle(pointerOffset, radius, totalCircle);
          }
        }
        path.lineTo(
            ((singleUnitOfWidth * totalNumberOfDataPoints) -
                (size.width / (totalNumberOfDataPoints * 2))),
            size.height - (topSpacing / 2));
        path.close();
        canvas.drawPath(path, dataPlotter);
        canvas.drawPath(path2, lineHighlighter);
      } else {
        totalCircle
          ..strokeWidth = strokeWidth
          ..color = dataPoints[i].dataPointColor
          ..style = PaintingStyle.stroke;
        radius = dataPoints[i].dataPointSize;
        dataPlotter
          ..color = dataPoints[i].lineColor
          ..strokeWidth = dataPoints[i].lineWidth
          ..style = PaintingStyle.stroke;

        pointerOffset = Offset(
            size.width -
                ((singleUnitOfWidth * totalNumberOfDataPoints) -
                    (size.width / (totalNumberOfDataPoints * 2))),
            ((size.height -
                        (size.height / max) *
                            (dataPoints[i].values[0] < 0
                                ? 0
                                : dataPoints[i].values[0])) +
                    2) -
                (topSpacing / 2));

        path.moveTo(pointerOffset.dx, pointerOffset.dy);
        if (dataPoints[i].showDataPoints) {
          canvas.drawCircle(pointerOffset, radius, totalCircle);
        }
        for (int j = 1; j < totalNumberOfDataPoints; j++) {
          // Calculating the offset of the data points.
          pointerOffset = Offset(
              size.width -
                  ((singleUnitOfWidth * (totalNumberOfDataPoints - j)) -
                      (size.width / (totalNumberOfDataPoints * 2))),
              ((size.height -
                          (size.height / max) *
                              (dataPoints[i].values[j] < 0
                                  ? 0
                                  : dataPoints[i].values[j])) +
                      2) -
                  (topSpacing / 2));

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
