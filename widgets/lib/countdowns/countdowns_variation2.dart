import 'dart:async';
import 'package:flutter/material.dart';

/// The [WOICountdownTimer] is a fully customizable digital timer.
///
/// Simply use the timer widget by calling it directly. This will build a widget with some pre-defined values of sizes and alignments. These values can be changed as per need.
/// ```dart
/// const WOICountdownTimer(
/// isHoursNeeded: true,
/// )
/// ```

class WOICountdownTimer extends StatefulWidget {
  /// Height of the complete widget.
  final double timerHeight;

  /// Width of the complete widget.
  final double timerWidth;

  /// Left and right padding of the contents of the widget.
  final double horizontalPadding;

  /// Top and bottom padding of the contents of the widget.
  final double verticalPadding;

  /// Font size of the timer digits.
  ///
  /// Will have to adjust the [scrollableTileSize] to avoid overflow issues.
  final double timerFontSize;

  /// Height of the scollable part of the timer. Increasing this will increase the number of digits visible in the scroller.
  final double scrollableHeight;

  /// Width of the scrollable part
  final double scollableWidth;

  /// Size of a single tile of the scollable.
  final double scrollableTileSize;

  /// Height of the start button.
  final double? startButtonHeight;

  /// Width of the start button.
  final double? startButtonWidth;

  /// Height of the stop button.
  final double? stopButtonHeight;

  /// Width of the stop button.
  final double? stopButtonWidth;

  /// Height of the pause buttton.
  final double? pauseButtonHeight;

  /// Width of the pause button.
  final double? pauseButtonWidth;

  /// Color of the active value on the scrollable.
  final Color selectedTimerValueColor;

  /// Color of the inactive value on the scrollable.
  final Color unselectedTimerValueColor;

  /// Widget of the start button of the timer. By default it is a text widget that says 'Start'.
  final Widget startButtonWidget;

  /// Widget of the pause button of the timer. By default it is a text widget that says 'Pause'.
  final Widget pauseButtonWidget;

  /// Widget of the stop button of the timer. By default it is a text widget that says 'Stop'.
  final Widget stopButtonWidget;

  /// Boolean value to determine if the color of the separator dots should change to the [selectedTimerValueColor] or stay white.
  final bool changeSeparatorColor;

  /// Option to choose if timer for hours is needed or not.
  final bool isHoursNeeded;

  /// Text style of the labels at top namely, the hours, minutes and seconds labels.
  final TextStyle labelTextStyle;

  /// The decoration of the widget as a whole.
  final BoxDecoration timerBoxDecoration;

  /// The decoration of the start button.
  final BoxDecoration? startButtonBoxDecoration;

  /// The decoration of the pause button.
  final BoxDecoration? pauseButtonBoxDecoration;

  /// The decoration of the stop button.
  final BoxDecoration? stopButtonBoxDecoration;

  /// This function is called once when the timer starts.
  final Function? onStart;

  /// This function is called every time the timer is paused.
  final Function(int timeValueInSeconds)? onPause;

  ///This function is called once when the timer is stopped.
  final Function? onStop;

  const WOICountdownTimer(
      {this.timerHeight = 250,
      this.timerWidth = 300,
      this.horizontalPadding = 25,
      this.verticalPadding = 15,
      this.timerFontSize = 35,
      this.scrollableHeight = 140,
      this.scollableWidth = 50,
      this.scrollableTileSize = 50,
      this.onStart,
      this.onPause,
      this.onStop,
      this.isHoursNeeded = false,
      this.startButtonWidget = const Text(
        'Start',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      this.pauseButtonWidget = const Text(
        'Pause',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      this.stopButtonWidget = const Text(
        'Stop',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      this.changeSeparatorColor = false,
      this.selectedTimerValueColor = Colors.white,
      this.unselectedTimerValueColor = Colors.grey,
      this.labelTextStyle = const TextStyle(color: Colors.white),
      this.timerBoxDecoration = const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.black,
      ),
      this.pauseButtonBoxDecoration,
      this.stopButtonBoxDecoration,
      this.startButtonBoxDecoration,
      this.pauseButtonHeight,
      this.pauseButtonWidth,
      this.startButtonHeight,
      this.startButtonWidth,
      this.stopButtonHeight,
      this.stopButtonWidth,
      super.key});

  @override
  State<WOICountdownTimer> createState() => _WOICountdownTimerState();
}

class _WOICountdownTimerState extends State<WOICountdownTimer> {
  List<int> secondsAndMinutes = List.generate(60, (index) => index);
  List<int> hours = List.generate(100, (index) => index);
  FixedExtentScrollController hoursController = FixedExtentScrollController();
  FixedExtentScrollController minutesController = FixedExtentScrollController();
  FixedExtentScrollController secondsController = FixedExtentScrollController();
  int selectedHours = 0;
  int selectedMinutes = 0;
  int selectedSeconds = 0;
  int totalTimeInSeconds = 0;
  bool startButtonPressed = false;
  bool pauseButtonPressed = false;
  bool timerStarted = false;
  late Timer timer;

  @override
  void dispose() {
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.timerHeight,
      width: widget.timerWidth,
      decoration: widget.timerBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
              vertical: widget.verticalPadding,
            ),
            child: widget.isHoursNeeded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: widget.isHoursNeeded,
                        child: Text(
                          'Hours',
                          style: widget.labelTextStyle,
                        ),
                      ),
                      Text(
                        'Minutes',
                        style: widget.labelTextStyle,
                      ),
                      Text(
                        'Seconds',
                        style: widget.labelTextStyle,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Minutes',
                        style: widget.labelTextStyle,
                      ),
                      Text(
                        'Seconds',
                        style: widget.labelTextStyle,
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
            ),
            child: widget.isHoursNeeded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: widget.scrollableHeight,
                        width: widget.scollableWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: hoursController,
                          physics: timerStarted
                              ? const NeverScrollableScrollPhysics()
                              : const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (value) {
                            selectedHours = value;
                            setState(() {});
                          },
                          itemExtent: widget.scrollableTileSize,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              hours.length,
                              (index) => Text(
                                hours[index].toString().length == 1
                                    ? '0${hours[index].toString()}'
                                    : hours[index].toString(),
                                style: TextStyle(
                                  fontSize: widget.timerFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: hours[index] == selectedHours
                                      ? widget.selectedTimerValueColor
                                      : widget.unselectedTimerValueColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ':',
                            style: TextStyle(
                              color: widget.changeSeparatorColor
                                  ? widget.selectedTimerValueColor
                                  : Colors.white,
                              fontSize: widget.timerFontSize,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.scrollableHeight,
                        width: widget.scollableWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: minutesController,
                          physics: timerStarted
                              ? const NeverScrollableScrollPhysics()
                              : const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (value) {
                            selectedMinutes = value;
                            setState(() {});
                          },
                          itemExtent: widget.scrollableTileSize,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              secondsAndMinutes.length,
                              (index) => Text(
                                secondsAndMinutes[index].toString().length == 1
                                    ? '0${secondsAndMinutes[index].toString()}'
                                    : secondsAndMinutes[index].toString(),
                                style: TextStyle(
                                  fontSize: widget.timerFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: secondsAndMinutes[index] ==
                                          selectedMinutes
                                      ? widget.selectedTimerValueColor
                                      : widget.unselectedTimerValueColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ':',
                            style: TextStyle(
                              color: widget.changeSeparatorColor
                                  ? widget.selectedTimerValueColor
                                  : Colors.white,
                              fontSize: widget.timerFontSize,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.scrollableHeight,
                        width: widget.scollableWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: secondsController,
                          physics: timerStarted
                              ? const NeverScrollableScrollPhysics()
                              : const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (value) {
                            selectedSeconds = value;
                            setState(() {});
                          },
                          itemExtent: widget.scrollableTileSize,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              secondsAndMinutes.length,
                              (index) => Text(
                                secondsAndMinutes[index].toString().length == 1
                                    ? '0${secondsAndMinutes[index].toString()}'
                                    : secondsAndMinutes[index].toString(),
                                style: TextStyle(
                                  fontSize: widget.timerFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: secondsAndMinutes[index] ==
                                          selectedSeconds
                                      ? widget.selectedTimerValueColor
                                      : widget.unselectedTimerValueColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: widget.scrollableHeight,
                        width: widget.scollableWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: minutesController,
                          physics: timerStarted
                              ? const NeverScrollableScrollPhysics()
                              : const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (value) {
                            selectedMinutes = value;
                            setState(() {});
                          },
                          itemExtent: widget.scrollableTileSize,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              secondsAndMinutes.length,
                              (index) => Text(
                                secondsAndMinutes[index].toString().length == 1
                                    ? '0${secondsAndMinutes[index].toString()}'
                                    : secondsAndMinutes[index].toString(),
                                style: TextStyle(
                                  fontSize: widget.timerFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: secondsAndMinutes[index] ==
                                          selectedMinutes
                                      ? widget.selectedTimerValueColor
                                      : widget.unselectedTimerValueColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ':',
                            style: TextStyle(
                              color: widget.changeSeparatorColor
                                  ? widget.selectedTimerValueColor
                                  : Colors
                                      .white, // If user sets changeSeparatorColor value to true its color will change according to the active timer value color that the user gives otherwise it will be white.
                              fontSize: widget.timerFontSize,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.scrollableHeight,
                        width: widget.scollableWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: secondsController,
                          physics: timerStarted
                              ? const NeverScrollableScrollPhysics()
                              : const FixedExtentScrollPhysics(), // Stops scroll when the timer has started.
                          onSelectedItemChanged: (value) {
                            selectedSeconds = value;
                            setState(() {});
                          },
                          itemExtent: widget.scrollableTileSize,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: List<Widget>.generate(
                              secondsAndMinutes.length,
                              (index) => Text(
                                secondsAndMinutes[index].toString().length == 1
                                    ? '0${secondsAndMinutes[index].toString()}'
                                    : secondsAndMinutes[index]
                                        .toString(), // Adds a 0 before a single digit int.
                                style: TextStyle(
                                  fontSize: widget.timerFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: secondsAndMinutes[index] ==
                                          selectedSeconds
                                      ? widget.selectedTimerValueColor
                                      : widget
                                          .unselectedTimerValueColor, // Different text color based on selected and unselected values.
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Visibility(
            visible: !startButtonPressed,
            child: GestureDetector(
              onTap: startButtonPressed
                  ? null
                  : () {
<<<<<<< Updated upstream
                      if (widget.onStart != null) {
                        widget.onStart!();
                      }
                      double scrollPositionHandler = widget.scrollableTileSize;
                      if (selectedSeconds != 0 ||
                          selectedMinutes != 0 ||
                          selectedHours != 0) {
                        startButtonPressed = true;
                        timerStarted = true;
                        if (selectedHours != 0) {
                          totalTimeInSeconds += (selectedHours * 360);
                        }
                        if (selectedMinutes != 0) {
                          totalTimeInSeconds += (selectedMinutes * 60);
                        }
                        totalTimeInSeconds += selectedSeconds;
                        int secondsEndTime = 0;
                        int minutesEndTime = 0;
                        if (minutesController.selectedItem != 0) {
                          secondsEndTime += 60;
                          secondsEndTime *= minutesController.selectedItem;
                        }
                        if (hoursController.selectedItem != 0) {
                          minutesEndTime += 60;
                          minutesEndTime *= hoursController.selectedItem;
                        }
                        timer = Timer.periodic(
                          const Duration(seconds: 1),
                          (timer) {
                            if (hoursController.selectedItem == 0 &&
                                minutesController.selectedItem ==
                                    -minutesEndTime &&
                                secondsController.selectedItem ==
                                    -secondsEndTime) {
                              timer.cancel();
                              totalTimeInSeconds = 0;
                              startButtonPressed = false;
                              timerStarted = false;
                              setState(() {});
                              return;
                            }
                            secondsController.selectedItem - 1;
                            secondsController.animateTo(
                              (secondsController.position.pixels -
                                  scrollPositionHandler),
                              duration: const Duration(milliseconds: 500),
                              curve: Easing.linear,
                            );
                            if (selectedSeconds == 0 && selectedMinutes != 0) {
                              minutesController.selectedItem - 1;
                              minutesController.animateTo(
                                (minutesController.position.pixels -
                                    scrollPositionHandler),
                                duration: const Duration(milliseconds: 500),
                                curve: Easing.linear,
                              );
                            }
                            if (selectedMinutes == 0 &&
                                selectedHours != 0 &&
                                selectedSeconds == 0 &&
                                minutesController.selectedItem !=
                                    minutesEndTime) {
                              hoursController.selectedItem - 1;
                              hoursController.animateTo(
                                (hoursController.position.pixels -
                                    scrollPositionHandler),
                                duration: const Duration(milliseconds: 500),
                                curve: Easing.linear,
                              );
                              minutesController.animateTo(
                                minutesController.position.pixels -
                                    scrollPositionHandler,
                                duration: const Duration(milliseconds: 500),
                                curve: Easing.linear,
                              );
                            }
                            setState(() {});
                          },
                        );
                      }
=======
                      startButtonHandler();
>>>>>>> Stashed changes
                    },
              child: Container(
                height: widget.startButtonHeight,
                width: widget.startButtonWidth,
                margin: EdgeInsets.only(bottom: widget.verticalPadding),
                decoration: widget.startButtonBoxDecoration,
                child: widget.startButtonWidget,
              ),
            ),
          ),
          Visibility(
            visible: startButtonPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
<<<<<<< Updated upstream
                    if (widget.onPause != null) {
                      widget.onPause!(totalTimeInSeconds);
                    }
                    double scrollPositionHandler = widget.scrollableTileSize;
                    int secondsEndTime = 0;
                    int minutesEndTime = 0;
                    if (minutesController.selectedItem != 0) {
                      secondsEndTime += 60;
                      secondsEndTime *= minutesController.selectedItem;
                    }
                    if (hoursController.selectedItem != 0) {
                      minutesEndTime += 60;
                      minutesEndTime *= hoursController.selectedItem;
                    }
                    if (pauseButtonPressed) {
                      pauseButtonPressed = false;
                      setState(() {});
                      timer = Timer.periodic(
                        const Duration(seconds: 1),
                        (timer) {
                          if (pauseButtonPressed) {
                            timer.cancel();
                            return;
                          }
                          if (hoursController.selectedItem == 0 &&
                              minutesController.selectedItem ==
                                  -minutesEndTime &&
                              secondsController.selectedItem ==
                                  -secondsEndTime) {
                            timer.cancel();
                            totalTimeInSeconds = 0;
                            startButtonPressed = false;
                            timerStarted = false;
                            setState(() {});
                            return;
                          }
                          secondsController.selectedItem - 1;
                          secondsController.animateTo(
                            (secondsController.position.pixels -
                                scrollPositionHandler),
                            duration: const Duration(milliseconds: 500),
                            curve: Easing.linear,
                          );
                          if (selectedSeconds == 0 && selectedMinutes != 0) {
                            minutesController.selectedItem - 1;
                            minutesController.animateTo(
                              (minutesController.position.pixels -
                                  scrollPositionHandler),
                              duration: const Duration(milliseconds: 500),
                              curve: Easing.linear,
                            );
                          }
                          if (selectedMinutes == 0 &&
                              selectedHours != 0 &&
                              selectedSeconds == 0 &&
                              minutesController.selectedItem !=
                                  minutesEndTime) {
                            hoursController.selectedItem - 1;
                            hoursController.animateTo(
                              (hoursController.position.pixels -
                                  scrollPositionHandler),
                              duration: const Duration(milliseconds: 500),
                              curve: Easing.linear,
                            );
                            minutesController.animateTo(
                              minutesController.position.pixels -
                                  scrollPositionHandler,
                              duration: const Duration(milliseconds: 500),
                              curve: Easing.linear,
                            );
                          }
                          setState(() {});
                        },
                      );
                    } else {
                      timer.cancel();
                      pauseButtonPressed = true;
                      setState(() {});
                    }
=======
                    pauseButtonHandler();
>>>>>>> Stashed changes
                  },
                  child: Container(
                    height: widget.pauseButtonHeight,
                    width: widget.pauseButtonWidth,
                    margin: EdgeInsets.only(bottom: widget.verticalPadding),
                    decoration: widget.pauseButtonBoxDecoration,
                    child: pauseButtonPressed
                        ? widget.startButtonWidget
                        : widget.pauseButtonWidget,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.onStop != null) {
                      widget.onStop!();
                    }
                    // Cancel timer and change state of timer and variables to their initial state.
                    timer.cancel();
                    totalTimeInSeconds = 0;
                    hoursController.jumpTo(0);
                    secondsController.jumpTo(0);
                    minutesController.jumpTo(0);
                    timerStarted = false;
                    startButtonPressed = false;
                    setState(() {});
                  },
                  child: Container(
                    height: widget.stopButtonHeight,
                    width: widget.stopButtonWidth,
                    margin: EdgeInsets.only(bottom: widget.verticalPadding),
                    decoration: widget.stopButtonBoxDecoration,
                    child: widget.stopButtonWidget,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void startButtonHandler() {
    if (widget.onStart != null) {
      widget.onStart!();
    }
    double scrollPositionHandler = widget.scrollableTileSize;
    if (selectedSeconds != 0 || selectedMinutes != 0 || selectedHours != 0) {
      startButtonPressed = true;
      timerStarted = true;
      if (selectedHours != 0) {
        totalTimeInSeconds += (selectedHours * 360);
      }
      if (selectedMinutes != 0) {
        totalTimeInSeconds += (selectedMinutes * 60);
      }
      totalTimeInSeconds += selectedSeconds;
      int secondsEndTime = 0;
      int minutesEndTime = 0;
      if (minutesController.selectedItem != 0) {
        secondsEndTime += 60;
        secondsEndTime *= minutesController.selectedItem;
      }
      if (hoursController.selectedItem != 0) {
        minutesEndTime += 60;
        minutesEndTime *= hoursController.selectedItem;
      }
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (hoursController.selectedItem == 0 &&
              minutesController.selectedItem == -minutesEndTime &&
              secondsController.selectedItem == -secondsEndTime) {
            timer.cancel();
            totalTimeInSeconds = 0;
            startButtonPressed = false;
            timerStarted = false;
            setState(() {});
            return;
          }
          // Seconds timer will keep decreasing unless all the timer values are 0
          secondsController.selectedItem - 1;
          secondsController.animateTo(
            (secondsController.position.pixels - scrollPositionHandler),
            duration: const Duration(milliseconds: 500),
            curve: Easing.linear,
          );
          if (selectedSeconds == 0 && selectedMinutes != 0) {
            // Minutes will decrease when the seconds value is 0 and minutes have been set to a non zero value.
            minutesController.selectedItem - 1;
            minutesController.animateTo(
              (minutesController.position.pixels - scrollPositionHandler),
              duration: const Duration(milliseconds: 500),
              curve: Easing.linear,
            );
          }
          if (selectedMinutes == 0 &&
              selectedHours != 0 &&
              selectedSeconds == 0 &&
              minutesController.selectedItem != minutesEndTime) {
            // Hours and minutes will decrease when minutes and seconds value is 0 and the current minute value in the scroll controller is not equal to the end scroll value for minutes.
            hoursController.selectedItem - 1;
            hoursController.animateTo(
              (hoursController.position.pixels - scrollPositionHandler),
              duration: const Duration(milliseconds: 500),
              curve: Easing.linear,
            );
            minutesController.animateTo(
              minutesController.position.pixels - scrollPositionHandler,
              duration: const Duration(milliseconds: 500),
              curve: Easing.linear,
            );
          }
          setState(() {});
        },
      );
    }
  }

  void pauseButtonHandler() {
    if (widget.onPause != null) {
      widget.onPause!(totalTimeInSeconds);
    }
    double scrollPositionHandler = widget.scrollableTileSize;
    int secondsEndTime = 0;
    int minutesEndTime = 0;
    if (pauseButtonPressed) {
      pauseButtonPressed = false;
      setState(() {});
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (pauseButtonPressed) {
            timer.cancel();
            return;
          }
          if (hoursController.selectedItem == 0 &&
              minutesController.selectedItem == -minutesEndTime &&
              secondsController.selectedItem == -secondsEndTime) {
            timer.cancel();
            totalTimeInSeconds = 0;
            startButtonPressed = false;
            timerStarted = false;
            setState(() {});
            return;
          }
          // Seconds timer will keep decreasing unless all the timer values are 0
          secondsController.selectedItem - 1;
          secondsController.animateTo(
            (secondsController.position.pixels - scrollPositionHandler),
            duration: const Duration(milliseconds: 500),
            curve: Easing.linear,
          );
          if (selectedSeconds == 0 && selectedMinutes != 0) {
            // Minutes will decrease when the seconds value is 0 and minutes have been set to a non zero value.
            minutesController.selectedItem - 1;
            minutesController.animateTo(
              (minutesController.position.pixels - scrollPositionHandler),
              duration: const Duration(milliseconds: 500),
              curve: Easing.linear,
            );
          }
          if (selectedMinutes == 0 &&
              selectedHours != 0 &&
              selectedSeconds == 0 &&
              minutesController.selectedItem != minutesEndTime) {
            // Hours and minutes will decrease when minutes and seconds value is 0 and the current minute value in the scroll controller is not equal to the end scroll value for minutes.
            hoursController.selectedItem - 1;
            hoursController.animateTo(
              (hoursController.position.pixels - scrollPositionHandler),
              duration: const Duration(milliseconds: 500),
              curve: Easing.linear,
            );
            minutesController.animateTo(
              minutesController.position.pixels - scrollPositionHandler,
              duration: const Duration(milliseconds: 500),
              curve: Easing.linear,
            );
          }
          setState(() {});
        },
      );
    } else {
      timer.cancel();
      pauseButtonPressed = true;
      setState(() {});
    }
  }
}
