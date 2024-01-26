import 'package:flutter/material.dart';

class WOIBarGraph extends StatefulWidget {
  const WOIBarGraph({super.key});

  @override
  State<WOIBarGraph> createState() => _WOIBarGraphState();
}

class _WOIBarGraphState extends State<WOIBarGraph> {
  int max = 4;
  int currentIndex = 0;
  List<double> height = [150, 200, 175, 100, 80, 140, 160];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            5,
            (index) {
              currentIndex = (max - index) * 50;
              if (currentIndex != 0) {
                return Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      width: 30,
                      child: Text(
                        currentIndex.toString(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 40),
                      width: 310,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40, left: 10),
                      width: 30,
                      child: Text(
                        currentIndex.toString(),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        7,
                        (index) {
                          return Container(
                            width: 44.28,
                            height: 5,
                            margin: EdgeInsets.only(top: 45),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(),
                                right: BorderSide(),
                                left: BorderSide(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            7,
            (index) {
              return Container(
                height: height[index],
                width: 20,
                margin: EdgeInsets.only(
                  left: index == 0 ? 52 : 25,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border(
                    top: BorderSide(),
                    left: BorderSide(),
                    right: BorderSide(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
