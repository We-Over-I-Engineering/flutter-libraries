import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/graphs/line_graph/data_line_properties.dart';

/// Painter to create the data points and the line joining them.
class DataPointPainter extends CustomPainter {
  /// List of the line properties class
  final List<LineProperties> dataPoints;

  /// Max value out of all the data points from every line.
  final double max;

  /// Spacing added to the top of the graph widget to adjust for backgorund color.
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
    double singleUnitOfHeight;
    int totalNumberOfDataPoints;
    double centerPositionCalculation;
    double horizontalPositionOfTheFirstDataPoint;
    double verticalPositionOfTheFirstDataPoint;
    double verticalPostionForAllDataPoints;

    for (int i = 0; i < dataPoints.length; i++) {
      // This calculates the total number of data points in a single line.
      // It is used to calculate the single unit of width
      totalNumberOfDataPoints = dataPoints[i].values.length;

      // singleUnitOfWidth is the total width of the canvas divided by the number of data points on a line.
      // This helps in finding the exact position of a data point.
      singleUnitOfWidth = size.width / totalNumberOfDataPoints;

      // singleUnitOfHeight is the total height of the canvas divided by the maximum data point from all the lines.
      // This helps in finding the exact position of a data point.
      singleUnitOfHeight = size.height / max;

      // Center position is calculated the same way as single unit of width except the total number of data points is multiplied by 2.
      // This centers the data point of every xaxis increment.
      centerPositionCalculation = (size.width / (totalNumberOfDataPoints * 2));

      horizontalPositionOfTheFirstDataPoint =
          ((singleUnitOfWidth * totalNumberOfDataPoints) -
              centerPositionCalculation);
      verticalPositionOfTheFirstDataPoint = (singleUnitOfHeight) *
          (dataPoints[i].values[0] < 0 ? 0 : dataPoints[i].values[0]);

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
        // To get the offset of the first we need to calculate the the horizontal position and the vertical position of the data point
        // To calculate the horizontal position we multiply single unit of width with the total number of points and subtract it with the width of the canvas.
        // We also subtract the center position calculation from the above equation.
        // To calculate the vertical position we simply multiply the single unit of height with the number of data points and subtract it from the total height of the canvas.
        // Incase the calculated vertical position is less than zero we equate it to 0 to prevent over flow.
        pointerOffset = Offset(
            size.width - horizontalPositionOfTheFirstDataPoint,
            ((size.height - verticalPositionOfTheFirstDataPoint) +
                    strokeWidth) -
                (topSpacing / 2));

        // Moving our painter to the first point
        path.moveTo(pointerOffset.dx, pointerOffset.dy);
        path2.moveTo(pointerOffset.dx, pointerOffset.dy);
        if (dataPoints[i].showDataPoints) {
          canvas.drawCircle(pointerOffset, radius, totalCircle);
        }
        for (int j = 1; j < dataPoints[i].values.length; j++) {
          verticalPostionForAllDataPoints = ((singleUnitOfHeight) *
              (dataPoints[i].values[j] < 0 ? 0 : dataPoints[i].values[j]));
          // Calculating the offset of the data points
          // To get the offset of the data points we need to calculate the the horizontal position and the vertical position of the data points
          // To calculate the horizontal position we multiply single unit of width with the number of positions the point holds on the xaxis from the right side and subtract it with the width of the canvas.
          // We also subtract the center position calculation from the above equation.
          // To calculate the vertical position we simply multiply the single unit of height with the number of data points and subtract it from the total height of the canvas.
          // Incase the calculated vertical position is less than zero we equate it to 0 to prevent over flow.
          pointerOffset = Offset(
              size.width -
                  ((singleUnitOfWidth * (totalNumberOfDataPoints - j)) -
                      centerPositionCalculation),
              ((size.height - verticalPostionForAllDataPoints) + strokeWidth) -
                  (topSpacing / 2));

          path.lineTo(pointerOffset.dx, pointerOffset.dy);
          path2.lineTo(pointerOffset.dx, pointerOffset.dy);
          if (dataPoints[i].showDataPoints) {
            canvas.drawCircle(pointerOffset, radius, totalCircle);
          }
        }
        path.lineTo(
            ((singleUnitOfWidth * totalNumberOfDataPoints) -
                centerPositionCalculation),
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

        // Offset of the first data point
        // To get the offset of the first we need to calculate the the horizontal position and the vertical position of the data point
        // To calculate the horizontal position we multiply single unit of width with the total number of points and subtract it with the width of the canvas.
        // We also subtract the center position calculation from the above equation.
        // To calculate the vertical position we simply multiply the single unit of height with the number of data points and subtract it from the total height of the canvas.
        // Incase the calculated vertical position is less than zero we equate it to 0 to prevent over flow.
        pointerOffset = Offset(
            size.width - horizontalPositionOfTheFirstDataPoint,
            ((size.height - (verticalPositionOfTheFirstDataPoint)) +
                    strokeWidth) -
                (topSpacing / 2));

        path.moveTo(pointerOffset.dx, pointerOffset.dy);
        if (dataPoints[i].showDataPoints) {
          canvas.drawCircle(pointerOffset, radius, totalCircle);
        }
        for (int j = 1; j < totalNumberOfDataPoints; j++) {
          verticalPostionForAllDataPoints = ((singleUnitOfHeight) *
              (dataPoints[i].values[j] < 0 ? 0 : dataPoints[i].values[j]));
          // Calculating the offset of the data points.
          // To get the offset of the data points we need to calculate the the horizontal position and the vertical position of the data points
          // To calculate the horizontal position we multiply single unit of width with the number of positions the point holds on the xaxis from the right side and subtract it with the width of the canvas.
          // We also subtract the center position calculation from the above equation.
          // To calculate the vertical position we simply multiply the single unit of height with the number of data points and subtract it from the total height of the canvas.
          // Incase the calculated vertical position is less than zero we equate it to 0 to prevent over flow.
          pointerOffset = Offset(
              size.width -
                  ((singleUnitOfWidth * (totalNumberOfDataPoints - j)) -
                      centerPositionCalculation),
              ((size.height - verticalPostionForAllDataPoints) + strokeWidth) -
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
