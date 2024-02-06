import 'package:flutter/material.dart';

class LineProperties {
  LineProperties({
    required this.values,
    this.lineWidth = 1,
    this.lineColor = Colors.blue,
    this.fillColor = Colors.lightBlue,
    this.dataPointColor = Colors.purple,
    this.filledGraph = false,
    this.showDataPoints = true,
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
