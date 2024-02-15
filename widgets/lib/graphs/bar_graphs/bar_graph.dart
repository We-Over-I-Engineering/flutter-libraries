import 'package:flutter/material.dart';
import 'dart:math' as math;

class WOIBarGraph extends StatefulWidget {
  const WOIBarGraph({
    super.key,
    required this.yaxisValues,
    required this.xaxisValues,
    required this.height,
    required this.width,
    this.yAxisLabel,
    this.xAxisLabel,
    this.graphHeadingText,
    this.barColors = Colors.blue,
    this.incrementColors = Colors.red,
    this.backgroundColor = Colors.white,
    this.barPadding = 5,
    this.yaxisTextAndLinePadding = 30,
    this.labelPadding,
    this.headingPadding,
    this.textStyle,
    this.yaxisLabelTextBoxSize = 30,
    this.headingTextBoxSize = 30,
    this.xaxisLableTextBoxSize = 30,
    this.topPadding = 0,
  });
  final List<double> yaxisValues;
  final List<String> xaxisValues;
  final double height;
  final double width;
  final Text? yAxisLabel;
  final Text? xAxisLabel;
  final Text? graphHeadingText;
  final Color barColors;
  final Color incrementColors;
  final Color backgroundColor;
  final double barPadding;
  final double yaxisTextAndLinePadding;
  final double? labelPadding;
  final double? headingPadding;
  final TextStyle? textStyle;
  final double yaxisLabelTextBoxSize;
  final double headingTextBoxSize;
  final double xaxisLableTextBoxSize;
  final double topPadding;

  @override
  State<WOIBarGraph> createState() => _WOIBarGraphState();
}

class _WOIBarGraphState extends State<WOIBarGraph> {
  double max = 0;
  double min = 0;
  double tempForMax = 0;
  double tempForMin = 0;
  double increment = 0.2;
  int roundingFactor = 1;
  // List<double> values = [];
  double numberOfIncrements = 0;
  List<double> divisions = [];
  double partinionValue = 0;
  double stepSize = 1.0;
  int positiveNumberOfIncrements = 0;
  int decimal = 0;

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

  List<double> createBackgroundDivision(List<double> values) {
    // if values are empty then return empty
    if (values.isEmpty) {
      return [];
    }

    // get the min and max values from the list
    double maxVal = values.reduce(math.max);
    double minVal = values.reduce(math.min);

    // If the max is less then 0 that means all values are negative
    // Then start the graph with 0 as the max value
    if (maxVal < 0) {
      maxVal = 0;
    }

    double maxTempVal = math.max(maxVal.abs(), minVal.abs());
    double minTempVal = math.min(maxVal.abs(), minVal.abs());

    // Calculate the range and dynamically determine an appropriate step size
    double range = maxTempVal + minTempVal;

    decimal = 0;
    double temp = range;
    // Calculate the number of decimal places
    while (temp < 1) {
      decimal++;
      temp = temp * 10;
    }

    // Start the step size based on the min value
    // For decimal start can be less then 1 and greater then 0
    stepSize = 1 * (decimal * 0.1);

    // If the numbers are decimal then add an extra for more accuracy
    if (decimal != 0) {
      decimal++;
    }

    // Calculate the step size to divide the background in
    while ((stepSize * 7) < temp) {
      stepSize += 1;
    }

    // If the numbers are in decimal then convert then to non decimal for easier calculations
    if (decimal > 0) {
      minVal = minVal * (10 * decimal);
      maxVal = maxVal * (10 * decimal);
    }

    // Find the nearest rounded values for min and max according to stepSize
    minVal = (minVal / stepSize).floor() * stepSize;
    maxVal = (maxVal / stepSize).ceil() * stepSize;

    // Finding the positive number of increments
    for (int i = 4; i < 8; i++) {
      if (maxVal % i == 0) {
        positiveNumberOfIncrements = i;
      }
    }

    // Ensure the division covers the entire range correctly, including an extra step if needed
    if (minVal - stepSize >=
        (values.reduce(math.min) / stepSize).floor() * stepSize) {
      minVal -= stepSize;
    }

    List<double> backgroundPositiveDivisions = [];

    // We have the min and max and then step count so now is the time to
    // populate the list
    for (double val = maxVal; val >= minVal; val -= stepSize) {
      double backgroundValue = val;
      // For decimal values convert back the values to the decimal
      if (decimal > 0) {
        backgroundValue = backgroundValue / (10 * decimal);
      }
      backgroundPositiveDivisions.add(backgroundValue);
    }

    // Sort the list as smaller values at then end and greater at the top
    backgroundPositiveDivisions.sort((a, b) => b.compareTo(a));

    // Return the list
    return backgroundPositiveDivisions;
  }

  bool isDecimal(num value) {
    return value is double && value % 1 != 0;
  }

  @override
  Widget build(BuildContext context) {
    roundingFactor = 1;

    // Max = the maximum value in the yaxisValues list.
    max = widget.yaxisValues.reduce(
      (value, element) => value > element ? value : element,
    );

    // min = the minimum value in the yaxisValues list.
    min = widget.yaxisValues.reduce(
      (value, element) => value < element ? value : element,
    );

    if (min < 0) {
      partinionValue = max - min;
    }

    max = partinionValue;

    divisions = createBackgroundDivision(widget.yaxisValues);
    max = divisions.first + divisions.last;
    min = divisions.last;

    // Calculate the value for a single section
    partinionValue = widget.height / (divisions.length - 1);

    return positiveGraph();
  }

  Widget positiveGraph() {
    return Container(
      color: widget.backgroundColor,
      width: (widget.width + widget.yaxisLabelTextBoxSize),
      child: Row(
        children: [
          Visibility(
            visible: widget.yAxisLabel != null,
            child: RotatedBox(
                quarterTurns: -1,
                child: SizedBox(
                    height: widget.yaxisLabelTextBoxSize,
                    width: widget.height,
                    child: widget.yAxisLabel)),
          ),
          SizedBox(
            width: widget.labelPadding,
          ),
          Container(
            color: widget.backgroundColor,
            child: Column(
              children: [
                Container(
                  height: widget.topPadding,
                  color: widget.backgroundColor,
                ),
                Visibility(
                  visible: widget.graphHeadingText != null,
                  child: SizedBox(
                      height: widget.headingTextBoxSize,
                      child: widget.graphHeadingText ?? Container()),
                ),
                SizedBox(
                  height: widget.headingPadding,
                ),
                Container(
                  height: widget.height,
                  width: widget.width,
                  color: widget.backgroundColor,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      yaxisLines(numberOfIncrements),
                      positiveGraphBars(),
                    ],
                  ),
                ),
                Container(
                  width: widget.width,
                  padding:
                      EdgeInsets.only(left: widget.yaxisTextAndLinePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      widget.xaxisValues.length,
                      (index) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: widget.barPadding,
                            right: widget.barPadding,
                          ),
                          child: Text(
                            widget.xaxisValues[index],
                            style: widget.textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.labelPadding,
                ),
                Visibility(
                  visible: widget.xAxisLabel != null,
                  child: SizedBox(
                      height: widget.xaxisLableTextBoxSize,
                      child: widget.xAxisLabel ?? Container()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget yaxisLines(double numberOfIncrements) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
            divisions.length - 1,
            (index) {
              return Container(
                child: Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: widget.yaxisLabelTextBoxSize,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            divisions[index].toStringAsFixed(decimal),
                            style: widget.textStyle ??
                                const TextStyle(
                                  height: 0.1,
                                ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: 0.5,
                                      color: widget.incrementColors,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ) +
          [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.yaxisLabelTextBoxSize,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        divisions.last.toStringAsFixed(decimal),
                        style: widget.textStyle ??
                            const TextStyle(
                              height: 0.1,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 0.5,
                                  color: widget.incrementColors,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
    );
  }

  Widget positiveGraphBars() {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.yaxisTextAndLinePadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          widget.xaxisValues.length,
          (index) {
            double hardCodedContainerHeight = 2;
            double barHeight = 0;
            double nagativeSectionsHeight = 0;
            double negativePadding = 0;
            double xAxisValue = 0;

            // Only initialize if y-axis values are less then the x axis
            // otherwise the default is 0 defined above
            if (index < widget.yaxisValues.length) {
              xAxisValue = widget.yaxisValues[index];
            }

            //If there is negative value in the graph
            if (divisions.last < 0) {
              // Calculate the number of negative sections
              double noOfNegativeSections = divisions.last / (stepSize);

              // Calculate the total height occupied by the negative sections
              nagativeSectionsHeight = partinionValue * (noOfNegativeSections);

              // Height of a single value
              double perValueHeight =
                  nagativeSectionsHeight.abs() / divisions.last.abs();

              // Calculate the height of with the new values
              barHeight =
                  perValueHeight * xAxisValue.abs() - hardCodedContainerHeight;

              if (isNegativeValue(index, xAxisValue)) {
                barHeight = perValueHeight * xAxisValue.abs();
              }

              // Calculate the padding to be added at the bottom of bar for
              // negative values
              negativePadding = nagativeSectionsHeight.abs() - barHeight;
            } else {
              // Height of a single value
              double perValueHeight = (widget.height / max);
              // Calculate bar height
              barHeight =
                  (perValueHeight * xAxisValue) - hardCodedContainerHeight;
            }

            // If the bar height is less then zero because of `hardCodedContainerHeight`
            // then declear as 0
            if (barHeight < 0) {
              barHeight = 0;
            }
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isNegativeValue(index, xAxisValue)
                      ? Column(
                          children: [
                            xAxisContainerBorder(hardCodedContainerHeight),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: widget.barPadding,
                      right: widget.barPadding,
                      bottom: isNegativeValue(index, xAxisValue)
                          ? (negativePadding)
                          : 0,
                    ),
                    child: Container(
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: widget.barColors,
                        border: const Border(
                          top: BorderSide(),
                          left: BorderSide(),
                          right: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  isNegativeValue(index, xAxisValue)
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                            bottom: nagativeSectionsHeight.abs(),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: xAxisContainerBorder(
                                    hardCodedContainerHeight),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool isNegativeValue(int index, double value) {
    return value < 0;
  }

  Widget xAxisContainerBorder(double hardCodedContainerHeight) {
    return Container(
      height: hardCodedContainerHeight,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
          top: BorderSide(
            color: Colors.black,
          ),
          right: BorderSide(
            color: Colors.black,
          ),
          left: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
