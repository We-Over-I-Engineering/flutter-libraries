import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/switches/switch_style_model.dart';

/// A widget that gives you option to toggle and switch between two sides
///
/// Here is the very basic way to use the widget
/// ```dart
///  WOISwitchButton(
///   value: switchValue,
///   onChanged: (bool isSelected) {
///     switchValue = isSelected;
///     setState(() {});
///   },
/// )
/// ```
///
/// The `value` and `onChanged` are required fields
/// `onChanged` field will return the data when ever the value is changed with the updated value on what should be the new value after the tap action
///
///
///
///
/// Furthure if you want to explore the full extent of the widget then we have the active and inactive states for the swtich as well which you can change by
/// providing the value for the `activeSwitchStyle` and `inActiveSwitchStyle` fields while both of them accepts the
/// `WOISwitchStyleModel` type value which is a custom model for styling of the widget
///
///
/// There will be a variabled named `thumbSize` saperately with in the widget and in both other fields `activeSwitchStyle` and `inActiveSwitchStyle`
/// The way it works is that if only `thumbSize` is provded without involving `thumbSize` fields from `activeSwitchStyle` and `inActiveSwitchStyle` then it will
/// be constant in both states other wise it will follow the respective size privded in both style variables
///
///
///
///
/// Here is the implementation with all utalization of its customization
/// ```dart
///
/// WOISwitchButton(
///   activeSwitchStyle: WOISwitchStyleModel(
///     thumbColor: Colors.green,
///     icon: const Icon(
///       Icons.woman_outlined,
///     ),
///     thumbBorder: Border.all(
///       color: Colors.red,
///     ),
///     trackColor: Colors.red,
///     trackBorder: Border.all(
///       color: Colors.black,
///       width: 4,
///     ),
///     thumbSize: 25,
///   ),
///   trackBorderRadius: 50,
///   thumbBorderRadius: 50,
///   inActiveSwitchStyle: WOISwitchStyleModel(
///     thumbColor: Colors.red,
///     thumbSize: 20,
///     thumbBorder: Border.all(
///       color: Colors.green,
///     ),
///     trackBorder: Border.all(
///       color: Colors.red,
///       width: 2,
///     ),
///     icon: const Icon(
///       Icons.person,
///       size: 15,
///       color: Colors.white,
///     ),
///     trackColor: Colors.green,
///   ),
///   value: switchValue,
///   onChanged: (bool isSelected) {
///     switchValue = isSelected;
///     setState(() {});
///   },
/// ),
///
/// ```

///

class WOISwitchButton extends StatefulWidget {
  const WOISwitchButton({
    super.key,
    this.activeSwitchStyle,
    this.inActiveSwitchStyle,
    this.trackHeight = 35,
    this.trackWidth = 70,
    this.thumbSize = 25,
    this.thumbMargin,
    required this.value,
    required this.onChanged,
    this.trackBorderRadius = 100,
    this.thumbBorderRadius = 100,
  });

  /// Define the height of the track. It is independent to the size of the thumb.
  final double? trackHeight;

  /// To define the width of the widget
  final double? trackWidth;

  /// This will be used to define the size for the thumb and it will be used for both active and inactive state unitl specificed in the style fields saperatly
  final double thumbSize;

  /// A style model for customize button in its active state
  final WOISwitchStyleModel? activeSwitchStyle;

  /// A style model for customize button in its in Active state
  final WOISwitchStyleModel? inActiveSwitchStyle;

  /// To provide the padding for the thumb on the outside
  final EdgeInsetsGeometry? thumbMargin;

  /// This is the value variable that will hold the value for the current state
  /// This is a `required` field
  final bool value;

  /// The variable returns the value when use taps on the widget in boolean
  final ValueChanged<bool> onChanged;

  /// This is to define the track border radius and this will be constant for active and in active state
  final double trackBorderRadius;

  /// This is to define the thumb border radius and this will be constant for active and in active state
  final double thumbBorderRadius;

  @override
  State<WOISwitchButton> createState() => _WOISwitchButtonState();
}

class _WOISwitchButtonState extends State<WOISwitchButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = const Duration(
      microseconds: 100,
    );

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () async {
            if (widget.value) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            widget.onChanged.call(!widget.value);
          },
          child: SizedBox(
            width: widget.trackWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  height: widget.trackHeight,
                  decoration: BoxDecoration(
                    border: _trackBackgroundBorder(),
                    borderRadius: BorderRadius.circular(
                      widget.trackBorderRadius,
                    ),
                    color: _trackColor(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: AnimatedAlign(
                    alignment: widget.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 100,
                      ),
                      margin: widget.thumbMargin ?? const EdgeInsets.all(5),
                      height: _thumbSize(),
                      width: _thumbSize(),
                      decoration: BoxDecoration(
                        color: _thumbColor(),
                        border: _thumbBorder(),
                        borderRadius: BorderRadius.circular(
                          widget.thumbBorderRadius,
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: _thumbIcon(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Border _trackBackgroundBorder() {
    Border border = Border.all();
    if (widget.value) {
      border = widget.activeSwitchStyle?.trackBorder ?? border;
    } else {
      border = widget.inActiveSwitchStyle?.trackBorder ?? border;
    }
    return border;
  }

  Color _trackColor() {
    Color color = Colors.white;
    if (widget.value) {
      color = widget.activeSwitchStyle?.trackColor ?? Colors.black;
    } else {
      color = widget.inActiveSwitchStyle?.trackColor ?? Colors.white;
    }
    return color;
  }

  Color _thumbColor() {
    Color color = Colors.white;
    if (widget.value) {
      color = widget.activeSwitchStyle?.thumbColor ?? Colors.white;
    } else {
      color = widget.inActiveSwitchStyle?.thumbColor ?? Colors.black;
    }
    return color;
  }

  Border _thumbBorder() {
    Border border = Border.all();
    if (widget.value) {
      border = widget.activeSwitchStyle?.thumbBorder ?? border;
    } else {
      border = widget.inActiveSwitchStyle?.thumbBorder ?? border;
    }
    return border;
  }

  Widget _thumbIcon() {
    if (widget.value) {
      return widget.activeSwitchStyle?.icon ?? Container();
    } else {
      return widget.inActiveSwitchStyle?.icon ?? Container();
    }
  }

  double _thumbSize() {
    double thumbSize = widget.thumbSize;
    if (widget.value) {
      return widget.activeSwitchStyle?.thumbSize ?? thumbSize;
    } else {
      return widget.inActiveSwitchStyle?.thumbSize ?? thumbSize;
    }
  }
}
