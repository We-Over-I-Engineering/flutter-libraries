import 'package:flutter/material.dart';

/// Propertie class for all the lines that will be created in the line graph.

class LineProperties {
  LineProperties({
    /// yaxis values for the line
    required this.values,

    /// Width of the data line
    this.lineWidth = 1,

    /// Color of the line
    this.lineColor = Colors.blue,

    /// Fill color of the area under the line
    this.fillColor = Colors.lightBlue,

    /// Color of the the data point circle
    this.dataPointColor = Colors.purple,

    /// Boolean too set if area under the data line should be filled or not
    this.filledGraph = false,

    /// Boolean to set if data point circle should be displayed or not
    this.showDataPoints = true,

    /// Size of the circular data points.
    this.dataPointSize = 2,
  });

  List<double> values;
  double lineWidth;
  Color lineColor;
  Color fillColor;
  Color dataPointColor;
  bool filledGraph;
  bool showDataPoints;
  double dataPointSize;
}
