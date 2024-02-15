import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/countdowns/countdowns_vairation1/countdown_variation1_state_enum.dart';

/// The [WOICountdowns] is a circular timer widget that has an optional initial pre timer loading timer.
/// Here is an example for the timer
///
/// ```dart
///  Padding(
///            padding: const EdgeInsets.all(20),
///            child: WOICountdowns(
///              timeInSeconds: 10,
///              timerSize: 200,
///              timerWidth: 20,
///             coolDownTimerValue: 3,
///              timerBackgroundColor: Colors.amber[100]!,
///              timerFillColor: Colors.amber,
///             cooldownTimerBoxDecoration: BoxDecoration(
///               color: Colors.grey.shade300,
///               borderRadius: BorderRadius.circular(200),
///             ),
///           ),
///         ),
/// ```
/// The [WOICountdowns] widget takes the timeInSeconds as a required variable which is the total time that the timer will run for.

class WOICountdowns extends StatefulWidget {
  /// The total time for which the timer will run.
  final double timeInSeconds;

  /// The time for for the initial ready up timer. Giving this a 0 value will remove the ready up timer.
  final int? coolDownTimerValue;

  /// Width of the circular timer.
  final double timerWidth;

  /// The space that the circular timer will take.
  final double timerSize;

  /// Color of the unfilled part of the timer.
  final Color timerBackgroundColor;

  /// Color of the filled part of the timer.
  final Color timerFillColor;

  /// The size of the initial widget that starts the timer and the size of the ready up timer.
  final double cooldownTimerSize;

  /// The center widget on the most initial state of the timer. By default it is the play arrow icon. Can be null.
  final Widget? initialCooldownTimerCenter;

  /// The center widget for when the timer is paused. Can be null
  final Widget? pausedTimerCenterWidget;

  /// The center widget when the timer is completed. Can be null
  final Widget? timerCompletionCenterWidget;

  /// The ready up timer countdown textstyle.
  final TextStyle? coolDownTimerTextStyle;

  /// Function that can be used to implement any changes for when the time on the timer changes. This function return the current value of time that the timer represents.
  final Function(double timerValue)? onChange;

  /// This function returns the current state of the widget and can be used to implement changes on state change. There are total of 5 states namely: initial, preTimerRunning, timerRunning, pausedTimer, timerCompleted.
  final Function(TimerState state)? onStateChange;

  /// Box decoration for the initial widget and the cooldown timer widget.
  final BoxDecoration cooldownTimerBoxDecoration;

  const WOICountdowns({
    required this.timeInSeconds,
    this.timerSize = 200,
    this.timerWidth = 15,
    this.timerBackgroundColor = Colors.lightBlue,
    this.timerFillColor = Colors.orange,
    this.cooldownTimerSize = 200,
    this.initialCooldownTimerCenter = const Icon(
      Icons.play_arrow_outlined,
      size: 100,
    ),
    this.cooldownTimerBoxDecoration = const BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.all(
        Radius.circular(200),
      ),
    ),
    this.coolDownTimerValue,
    this.coolDownTimerTextStyle,
    this.pausedTimerCenterWidget = const Icon(
      Icons.pause,
      size: 100,
    ),
    this.timerCompletionCenterWidget = const Icon(
      Icons.celebration,
      size: 100,
    ),
    this.onChange,
    this.onStateChange,
    super.key,
  });

  @override
  State<WOICountdowns> createState() => _WOICountdownsState();
}

class _WOICountdownsState extends State<WOICountdowns> {
  late int cooldownTimer;
  TimerState timerState = TimerState.initial;
  double progressValue = 0;

  @override
  void initState() {
    cooldownTimer = widget.coolDownTimerValue ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return timerWidget();
  }

  // Function to update the state of the timer eg from start to pause.
  void updateState(TimerState value) {
    timerState = value;
    if (widget.onStateChange != null) {
      widget.onStateChange!(timerState);
    }
    setState(() {});
  }

  // Function to update the value of the timer i.e the fill color.
  void updateTimer() {
    progressValue += (1 / widget.timeInSeconds);
    if (widget.onChange != null) {
      widget.onChange!(progressValue);
    }
    setState(() {});
  }

  // The function to return the appropriate widget based on the state.
  Widget timerWidget() {
    if (timerState == TimerState.initial) {
      return GestureDetector(
        onTap: () {
          if (cooldownTimer == 0) {
            updateState(TimerState.timerRunning);
            Timer.periodic(
              const Duration(seconds: 1),
              (timer) {
                // If the timer is presed during running state it will be canceled/paused.
                if (timerState == TimerState.pausedTimer) {
                  timer.cancel();
                  return;
                }
                // Progress value is between 0 and 1 so if progress value is equal to 1 or greater the timer will be completed.
                if (progressValue >= 1) {
                  updateState(TimerState.timerCompleted);
                  setState(() {});
                  timer.cancel();
                  return;
                }
                updateTimer();
                setState(() {});
              },
            );
          }
          if (cooldownTimer != 0) {
            updateState(TimerState.preTimerRunning);
            setState(() {});

            Timer.periodic(const Duration(seconds: 1), (timer) {
              if (timerState == TimerState.initial) {
                timer.cancel();
                return;
              }
              if (cooldownTimer == 0) {
                updateState(TimerState.timerRunning);
                if (timerState == TimerState.timerRunning) {
                  timer.cancel();
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (timerState == TimerState.pausedTimer) {
                      timer.cancel();
                      return;
                    }
                    if (progressValue >= 1) {
                      updateState(TimerState.timerCompleted);
                      setState(() {});
                      timer.cancel();
                      return;
                    }
                    updateTimer();
                    setState(() {});
                  });
                }
                setState(() {});
              }
              cooldownTimer--;
              setState(() {});
            });
          }
        },
        child: Container(
          height: widget.cooldownTimerSize,
          width: widget.cooldownTimerSize,
          decoration: widget.cooldownTimerBoxDecoration,
          child: Center(
            child: widget.initialCooldownTimerCenter,
          ),
        ),
      );
    }
    if (timerState == TimerState.preTimerRunning) {
      return GestureDetector(
        onTap: () {
          updateState(TimerState.initial);
          cooldownTimer = widget.coolDownTimerValue ?? 0;
          setState(() {});
        },
        child: Container(
          height: widget.cooldownTimerSize,
          width: widget.cooldownTimerSize,
          decoration: widget.cooldownTimerBoxDecoration,
          child: Center(
            child: Text(
              cooldownTimer.toString(),
              style: widget.coolDownTimerTextStyle,
            ),
          ),
        ),
      );
    }
    if (timerState == TimerState.timerRunning) {
      return GestureDetector(
        onTap: () {
          updateState(TimerState.pausedTimer);
          setState(() {});
        },
        child: SizedBox(
          height: widget.timerSize,
          width: widget.timerSize,
          child: CircularProgressIndicator(
            strokeWidth: widget.timerWidth,
            value: progressValue,
            backgroundColor: widget.timerBackgroundColor,
            color: widget.timerFillColor,
            strokeCap: StrokeCap.round,
          ),
        ),
      );
    }
    if (timerState == TimerState.pausedTimer) {
      return GestureDetector(
        onTap: () {
          updateState(TimerState.timerRunning);
          setState(() {});
          Timer.periodic(const Duration(seconds: 1), (timer) {
            if (timerState == TimerState.pausedTimer) {
              timer.cancel();
              return;
            }
            if (progressValue >= 1) {
              updateState(TimerState.timerCompleted);
              setState(() {});
              timer.cancel();
              return;
            }
            updateTimer();
            setState(() {});
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: widget.timerSize,
              width: widget.timerSize,
              child: CircularProgressIndicator(
                strokeWidth: widget.timerWidth,
                value: progressValue,
                backgroundColor: widget.timerBackgroundColor,
                color: widget.timerFillColor,
                strokeCap: StrokeCap.round,
              ),
            ),
            SizedBox(
              child: widget.pausedTimerCenterWidget ??
                  widget.pausedTimerCenterWidget,
            ),
          ],
        ),
      );
    }
    if (timerState == TimerState.timerCompleted) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: widget.timerSize,
            width: widget.timerSize,
            child: CircularProgressIndicator(
              strokeWidth: widget.timerWidth,
              value: progressValue,
              backgroundColor: widget.timerBackgroundColor,
              color: widget.timerFillColor,
              strokeCap: StrokeCap.round,
            ),
          ),
          SizedBox(
            child: widget.timerCompletionCenterWidget ??
                widget.timerCompletionCenterWidget,
          ),
        ],
      );
    }

    // Default widget returned on initial state. This is a dummy and will never be returned.
    return SizedBox(
      height: widget.timerSize,
      width: widget.timerSize,
      child: CircularProgressIndicator(
        strokeWidth: widget.timerWidth,
        value: progressValue,
        backgroundColor: widget.timerBackgroundColor,
        color: widget.timerFillColor,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
