import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/progress_bar/section_bar/section_bar_painter.dart';

/// This is a variation of the progress bar called a section bar.
/// The [WOISectionBar] can be divided into multiple different sections that jointly tracks the progress and completion of a single task.
/// Each section as defined by the user can track the progress of all hierarchical steps needed to achieve a goal.
/// The section bar takes width and a list called sections as required parameters. Sections can not contain a value of 0 and currentProgress cannot be greater that the sum of all elements in the section list.
///
/// Here is an example of the [WOISectionBar]
///
/// ```dart
/// const SizedBox(
///       child: WOISectionBar(
///   width: 375,
/// initialValue: 0,
/// sections: [4, 10, 6, 8],
/// currentProgress: 3,
/// tiltValue: 0,
/// sectionSpacing: 0,
/// barBottomPadding: 0,
/// prefixAndSuffixText: true,
/// borderedSections: true,
/// inactiveBarColor: Colors.white,
/// activeBarColor: Colors.red,
/// borderColor: Colors.orange,
/// borderWidth: 3,
///   ),
/// ),
/// ```
///
/// The [WOISectionBar] takes width and a list of sections as required parameters and offers a wide range of parameters that fully customize the widget to fulfill differing needs.

class WOISectionBar extends StatefulWidget {
  /// Width of the [WOISectionBar] is a required field.
  final double width;

  /// This list takes number of units of space and progress that each section will take.
  /// Example [4, 10, 6, 8] will create 4 sections where first section will go from 0-4 and second will go from 5-14 all the way up to 28 which is the final value.
  /// The list cannot accept 0 as a value.
  /// Hard refresh is recommended when this list is changed.
  final List<int> sections;

  /// The starting progress value. By default the initial value is 0.
  final int initialValue;

  /// The color of the sections on which are not being tracked.
  final Color inactiveBarColor;

  /// The color of the sections being tracked.
  final Color activeBarColor;

  /// The color of the progress indicator.
  final Color progressIndicatorColor;

  /// The font style of the prefix, suffix and progress indicator text.
  final TextStyle fontStyle;

  /// Tilt value controls the tilt of the left and the right borders of the sections.
  /// Negative value will give a left tilt and positive value will give a right tilt.
  final double tiltValue;

  /// Padding between the [WOISectionBar] and the prefix and suffix text and also between the progress indicator and its text.
  final double textPadding;

  /// This is used to change the size of the progress indicator.
  final double progressIndicatorSize;

  /// This is used to modify or remove the shadow of the progress indicator.
  final BoxShadow progressIndicatorShadow;

  /// This is to change the border radius of the progress indicator which can give the widget a more squarer shape.
  final double progressIndicatorBorderRadius;

  /// This field is only required in case the tilt value is 0.
  /// It changes the spacing between each section.
  final double sectionSpacing;

  /// This field is used in case the bar height is changed.
  /// It is used to fix the alignment of the of the [WOISectionBar] and its progress indicator.
  final double barBottomPadding;

  /// This is the tracking metric of [WOISectionBar]. This value cannot be more than the sum of values of sections list.
  final int currentProgress;

  /// This modifies the hight of the bar of the [WOISectionBar].
  final double barHeight;

  /// Boolean variable to check if the prefix and suffix text is needed to be displayed.
  /// Default value is true.
  final bool prefixAndSuffixText;

  /// Boolean variable to check if the sections need to have borders or not.
  /// Default value is false.
  final bool borderedSections;

  /// Modifies the width of the border if the borderedSections boolean variable is set to true.
  final double borderWidth;

  /// Modifies the color of the border if the borderedSections boolean variable is set to true.
  final Color borderColor;

  /// The [WOISectionBar] can be divided into multiple different sections that jointly tracks the progress and completion of a single task.
  /// Each section as defined by the user can track the progress of all hierarchical steps needed to achieve a goal.
  /// The section bar takes width and a list called sections as required parameters. Sections can not contain a value of 0 and currentProgress cannot be greater that the sum of all elements in the section list.
  WOISectionBar({
    super.key,
    required this.width,
    required this.sections,
    this.borderedSections = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.prefixAndSuffixText = true,
    this.barHeight = 15,
    this.progressIndicatorShadow = const BoxShadow(
      color: Colors.black,
      blurRadius: 10,
      spreadRadius: 0,
    ),
    this.currentProgress = 0,
    this.progressIndicatorColor = Colors.white,
    this.progressIndicatorBorderRadius = 20,
    this.barBottomPadding = 0,
    this.sectionSpacing = 5,
    this.progressIndicatorSize = 25,
    required this.initialValue,
    this.inactiveBarColor = Colors.grey,
    this.activeBarColor = Colors.blueGrey,
    this.fontStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: Colors.grey,
    ),
    this.tiltValue = 5,
    this.textPadding = 5,
  })  : assert(!sections.contains(0), 'List can not have the value 0'),
        assert(
            currentProgress <=
                sections.reduce((value, element) => value + element),
            'Current progress cannot be greater than the sum of elements of sections list.');

  @override
  State<WOISectionBar> createState() => _WOISectionBarState();
}

class _WOISectionBarState extends State<WOISectionBar> {
  int mainIndex = 0;
  int sumOfActiveIndexValues = 0;
  Map<int, List<int>> activeSectionFinder = {};
  int finalValue = 0;
  @override
  void initState() {
    for (int i = 0; i < widget.sections.length; i++) {
      finalValue += widget.sections[i];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.prefixAndSuffixText,
              child: Padding(
                padding: EdgeInsets.only(right: widget.textPadding),
                child: Text(
                  widget.initialValue.toString(),
                  style: widget.fontStyle,
                ),
              ),
            ),
            Container(
              width: widget.width,
              margin: EdgeInsets.only(bottom: widget.barBottomPadding),
              child: Row(
                children: List.generate(
                  widget.sections.length,
                  (index) {
                    return Expanded(
                      flex: widget.sections[index],
                      child: Container(
                        padding: widget.tiltValue ==
                                0 //Padding will only be applied if the tilt is 0
                            ? index ==
                                    widget.sections.length -
                                        1 //Padding will not be applied on the right of the last container
                                ? null
                                : EdgeInsets.only(right: widget.sectionSpacing)
                            : null,
                        height: widget.barHeight,
                        child: CustomPaint(
                          painter: SectionBarPainter(
                            barColor: index == getActiveIndex()
                                ? widget.activeBarColor
                                : widget.inactiveBarColor,
                            tiltValue: widget.tiltValue,
                            borderedSections: widget.borderedSections,
                            borderColor: widget.borderColor,
                            borderWidth: widget.borderWidth,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: widget.prefixAndSuffixText,
              child: Padding(
                padding: EdgeInsets.only(left: widget.textPadding),
                child: Text(
                  finalValue.toString(),
                  style: widget.fontStyle,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ((widget.width / (finalValue - widget.initialValue)) *
                    widget.currentProgress) -
                ((widget.width / (finalValue - widget.initialValue)) *
                    widget
                        .initialValue), //Calculates the length of 1 unit of progress and multiplies it with the current progress to position the progress indicator correctly
          ),
          child: Column(
            children: [
              Text(
                widget.currentProgress.toString(),
                style: widget.fontStyle,
              ),
              SizedBox(
                height: widget.textPadding,
              ),
              Container(
                height: widget.progressIndicatorSize,
                width: widget.progressIndicatorSize,
                decoration: BoxDecoration(
                  color: widget.progressIndicatorColor,
                  borderRadius: BorderRadius.circular(
                    widget.progressIndicatorBorderRadius,
                  ),
                  boxShadow: [
                    widget.progressIndicatorShadow,
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// This is to calculate the current active section of the bar and change color accordingly.
  int getActiveIndex() {
    for (int i = 0; i < widget.sections.length; i++) {
      if (i == 0) {
        sumOfActiveIndexValues = widget.initialValue;
      }
      activeSectionFinder[i] = [
        sumOfActiveIndexValues,
        sumOfActiveIndexValues + widget.sections[i]
      ];
      sumOfActiveIndexValues += widget.sections[i];
    }
    for (int i = 0; i < activeSectionFinder.length; i++) {
      if (widget.currentProgress > activeSectionFinder[i]![0] &&
          widget.currentProgress <= activeSectionFinder[i]![1]) {
        mainIndex = i;
        break;
      }
    }
    return mainIndex;
  }
}
