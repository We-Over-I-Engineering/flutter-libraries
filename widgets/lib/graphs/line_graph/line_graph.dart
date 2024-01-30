import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/graphs/line_graph/line_graph_painter.dart';

class WOILineGraph extends StatefulWidget {
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
  }) : assert(yaxisValues.length == xaxisValues.length,
            'yaxis and xaxis should have equal number of entries');

  final double height;
  final double width;
  final List<double> yaxisValues;
  final List xaxisValues;
  final double dataPointSize;
  final double lineWidth;
  final double yaxisTextBoxWidth;
  final double xaxisSeparatorLength;
  final double xaxisAndTextGap;
  final double topSpacing;
  final bool filledGraph;
  final Color lineColor;
  final Color fillColor;
  final Color dataPointColor;
  final Color backgroundColor;
  final Color incrementLineColor;

  @override
  State<WOILineGraph> createState() => _WOILineGraphState();
}

class _WOILineGraphState extends State<WOILineGraph> {
  double max = 0;
  double tempForMax = 0;
  double increment = 0.2;
  int numberOfIncrements = 4;
  int roundingFactor = 1;
  List<double> values = [];

  bool isDivisibleBy10(double value) {
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
    roundingFactor = 1;
    max = widget.yaxisValues.reduce(
      (value, element) => value > element ? value : element,
    );
    tempForMax = max;
    while (max.ceil() != max.floor()) {
      max = tempForMax * roundingFactor;
      roundingFactor *= 10;
    }

    while (!isDivisibleBy10(max)) {
      max++;
    }

    for (var i = 0; i < 7; i++) {
      if ((max) % (i + 1) == 0) {
        values.add(i + 1);
      }
    }

    double partitionValue =
        values.reduce((value, element) => value > element ? value : element);
    max /= (roundingFactor / 10);
    increment = (max) / partitionValue;
    numberOfIncrements = ((max) / increment).ceil();
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
                  numberOfIncrements,
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
                        Expanded(
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
                        )
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
