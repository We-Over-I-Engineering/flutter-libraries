import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/graphs/line_graph/line_graph_painter.dart';

/// [WOILineGraph] is a simple and easy to use line graph widget.
///
/// Here is an example of the [WOILineGraph]
///
/// ```dart
///  WOILineGraph(
///             height: 300,
///          width: 340,
///       yaxisValues: const [0.1, 0.2, 0.3, 0.4, 10, 0.6, 0.7, 0.8, 0.1],
///    xaxisValues: const [1, 2, 3, 4, 5, 6, 'Sun', '', ''],
/// filledGraph: true,
///    dottedYaxis: true,
///   dataPointColor: Colors.grey,
/// dataPointSize: 2,
/// xaxisAndTextGap: 20,
///  xaxisSeparatorLength: 3,
/// fillColor: Colors.lightBlue.withOpacity(0.2),
/// lineColor: Colors.blue,
///),
///,,,
///

class WOILineGraph extends StatefulWidget {
  /// The [WOILineGraph] essentially requires four variables i.e height, width, xaxisValues, yaxisValues.
  /// Number of entries should be equal in the xaxisValues and the yaxisValues list.
  const WOILineGraph({
    super.key,
    required this.height,
    required this.width,
    required this.yaxisValues,
    required this.xaxisValues,
    this.dataPointSize = 2,
    this.yaxisTextBoxWidth = 40,
    this.filledGraph = false,
    this.dataPointColor = Colors.purple,
    this.fillColor = Colors.lightBlue,
    this.lineColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.lineWidth = 1,
    this.xaxisSeparatorLength = 3,
    this.xaxisAndTextGap = 30,
    this.topSpacing = 10,
    this.incrementLineColor = Colors.red,
    this.dottedYaxis = false,
  }) : assert(yaxisValues.length == xaxisValues.length,
            'yaxis and xaxis should have equal number of entries');

  /// The height from the xaxis to the top most increment.
  final double height;

  /// The width of the complete widget.
  final double width;

  /// The yaxis points for every data point.
  final List<double> yaxisValues;

  /// The xaxis points for every data point.
  final List xaxisValues;

  /// Size of the circle depicting the data point.
  final double dataPointSize;

  /// Width of the line connecting the data points.
  final double lineWidth;

  /// Width of the text box wrapping the increments on the yaxis. This can be used to fix overflow issues if the text size increases.
  final double yaxisTextBoxWidth;

  /// Length of the vertical lines separating each xaxis increment.
  final double xaxisSeparatorLength;

  /// Gap between the xaxis and its values.
  final double xaxisAndTextGap;

  /// Changes height of the widget to adjust for how much of the top area needs to be incorporated in the background color.
  final double topSpacing;

  /// Set to true if the bottom of the data points line needs to be colored.
  final bool filledGraph;

  /// Change the style of the yaxis lines from solid to dotted.
  final bool dottedYaxis;

  /// Color of the data point line.
  final Color lineColor;

  /// Color below the data point line. Only needed if the filledGraph variable is set to true.
  final Color fillColor;

  /// Color of the data points.
  final Color dataPointColor;

  /// Background color of the graph
  final Color backgroundColor;

  /// Color of the yaxis increment lines. Set this to transparent to get rid of the lines.
  final Color incrementLineColor;

  @override
  State<WOILineGraph> createState() => _WOILineGraphState();
}

class _WOILineGraphState extends State<WOILineGraph> {
  double max = 0;
  double tempForMax = 0;
  double increment = 0.2;
  double numberOfIncrements = 0;
  int roundingFactor = 1;
  List<double> values = [];

  // Function to check if the max value is divisble by 0.5, 5 or 10.
  bool isDivisibleByRequiredIncrement(double value) {
    if (value % 10 == 0) {
      return true;
    }
    if (value % 5 == 0) {
      return true;
    }
    if (value % 0.5 == 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    values.clear();
    roundingFactor = 1;

    // Max = the maximum value in the yaxisValues list.
    max = widget.yaxisValues.reduce(
      (value, element) => value > element ? value : element,
    );
    tempForMax = max;

    // If max value < 0, convert it to integer.
    while (max.ceil() != max.floor()) {
      max = tempForMax * roundingFactor;
      roundingFactor *= 10;
    }

    // If max is not divisible by either 0.5, 5, 10 keep updating it.
    while (!isDivisibleByRequiredIncrement(max)) {
      max++;
    }

    // Calculating the number of increments possible for the given data. Max is 7.
    for (var i = 0; i < 7; i++) {
      if ((max) % (i + 1) == 0) {
        values.add(i + 1);
      }
    }

    // partitionValue is the max value from values list which means we are using maximum number of partitions
    numberOfIncrements =
        values.reduce((value, element) => value > element ? value : element);

    // Convert the max value back to < 0 if needed.
    if (roundingFactor != 1) {
      max /= (roundingFactor / 10);
    }

    // Value of each increment.
    increment = (max) / numberOfIncrements;

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        graphLayout(),
        painterForDataPlotting(),
      ],
    );
  }

  Widget painterForDataPlotting() {
    return Container(
      width: widget.width - widget.yaxisTextBoxWidth,
      margin: EdgeInsets.only(
        bottom: widget.xaxisAndTextGap + widget.xaxisSeparatorLength,
        top: widget.topSpacing,
      ),
      child: CustomPaint(
        size: Size.fromHeight(
          widget.height - widget.xaxisSeparatorLength,
        ),
        painter: DataPointPainter(
          dataPoints: widget.yaxisValues,
          max: max,
          isFilled: widget.filledGraph,
          lineColor: widget.lineColor,
          fillColor: widget.fillColor,
          dataPointColor: widget.dataPointColor,
          lineWidth: widget.lineWidth,
          dataPointSize: widget.dataPointSize,
        ),
      ),
    );
  }

  Widget graphLayout() {
    return Column(
      children: [
        Container(
          height: widget.topSpacing,
          width: widget.width,
          color: widget.backgroundColor,
        ),
        Container(
          height: widget.height,
          width: widget.width,
          color: widget.backgroundColor,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // y-Axis implementation
              Column(
                children: List.generate(
                  numberOfIncrements.toInt(),
                  (index) => Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.yaxisTextBoxWidth,
                          child: Text(
                            (increment * (numberOfIncrements - index))
                                .toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            style: const TextStyle(height: 0.1),
                          ),
                        ),
                        Visibility(
                          visible: widget.dottedYaxis,
                          child: Expanded(
                            child: Row(
                              children: List.generate(
                                30,
                                (index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: (widget.width -
                                                widget.yaxisTextBoxWidth) /
                                            60,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 1,
                                              color: widget.incrementLineColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: (widget.width -
                                                widget.yaxisTextBoxWidth) /
                                            60,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 1,
                                              color: widget.backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !widget.dottedYaxis,
                          child: Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1,
                                    color: widget.incrementLineColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // x-Axis implementation
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: widget.yaxisTextBoxWidth,
                    child: const Text(
                      '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 0.7),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: List.generate(
                        widget.xaxisValues.length,
                        (index) {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: widget.xaxisSeparatorLength,
                                  decoration: BoxDecoration(
                                    border: index == 0
                                        ? const Border(
                                            top: BorderSide(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            left: BorderSide(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            right: BorderSide(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                          )
                                        : const Border(
                                            top: BorderSide(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            right: BorderSide(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: widget.backgroundColor,
          width: widget.width,
          height: widget.xaxisAndTextGap,
          child: Row(
            children: [
              SizedBox(
                width: widget.yaxisTextBoxWidth,
                child: const Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 0.1),
                ),
              ),
              SizedBox(
                width: widget.width - widget.yaxisTextBoxWidth,
                child: Row(
                  children: List.generate(
                    widget.xaxisValues.length,
                    (index) => Expanded(
                      child: Text(
                        '${widget.xaxisValues[index]}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
