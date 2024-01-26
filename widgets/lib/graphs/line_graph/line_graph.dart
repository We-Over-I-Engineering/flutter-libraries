import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/graphs/line_graph/line_graph_painter.dart';

class WOILineGraph extends StatefulWidget {
  const WOILineGraph({
    super.key,
    required this.yaxisValues,
    required this.xaxisValues,
  });

  final List<double> yaxisValues;
  final List xaxisValues;

  @override
  State<WOILineGraph> createState() => _WOILineGraphState();
}

class _WOILineGraphState extends State<WOILineGraph> {
  double bottomMargin = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        graphLayout(),
        painterForDataPlotting(),
      ],
    );
  }

  Widget painterForDataPlotting() {
    return SizedBox(
      width: 300,
      child: CustomPaint(
        size: const Size.fromHeight(300),
        painter: DataPointPainter(
          dataPoints: widget.yaxisValues,
        ),
      ),
    );
  }

  Widget graphLayout() {
    return Container(
      height: 300,
      width: 340,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // y-Axis implementation
          Column(
            children: List.generate(
              5,
              (index) => Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${30 * (5 - index)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(height: 0.1),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1, color: Colors.red),
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
              const SizedBox(
                width: 40,
                child: Text(
                  '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 0.1),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(
                    7,
                    (index) {
                      bottomMargin =
                          ((300 / 150) * widget.yaxisValues[index]) - 6;
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 5,
                              width: 5,
                              margin: EdgeInsets.only(
                                  bottom: bottomMargin < 0 ? 0 : bottomMargin),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                            ),
                            Container(
                              height: 3,
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
    );
  }
}
