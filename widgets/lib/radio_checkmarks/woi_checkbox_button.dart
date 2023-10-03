import 'package:flutter/material.dart';

/// A widget that gives you option to toggle between 2 values as a checkBox
///
/// Here is the very basic way to use the widget
/// ```dart
///WOICheckBox(
///   isChecked: checkValue,
///   onTap: (bool isSelected) {
///     checkValue = isSelected;
///     setState(() {});
///   },
/// )
/// ```
///
/// The `isChecked` and `onTap` are required fields
/// `onTap` field will return the data when ever the value is changed with the updated value on what should be the new value after the tap action
///
///
///
///
/// Furthure if you want to explore the full extent of the widget then we have the checked and simple states
/// so to customize the checkbox in its checked state there would be variables
/// starting from [checked] or would have [checked] in them.
///
///
///
///
/// Here is the implementation with all utalization of its customization
/// ```dart
/// WOICheckBox(
///   isChecked: switchValue,
///   onTap: (bool isSelected) {
///     switchValue = isSelected;
///     setState(() {});
///   },
///   border: Border.all(
///     color: Colors.green,
///     width: 5,
///   ),
///   checkedBorder: Border.all(
///     color: Colors.black,
///     width: 2,
///   ),
///   checkedFillColor: Colors.red,
///   size: 50,
///   innerPadding: const EdgeInsets.all(3),
///   duration: const Duration(
///     milliseconds: 1,
///   ),
///   icon: const Icon(
///     Icons.check_outlined,
///     color: Colors.black,
///   ),
///   borderRadius: 100,
/// ),
/// ```

class WOICheckBox extends StatelessWidget {
  const WOICheckBox({
    super.key,
    required this.isChecked,
    required this.onTap,
    this.border,
    this.checkedBorder,
    this.checkedFillColor,
    this.size = 25,
    this.innerPadding,
    this.duration,
    this.borderRadius = 0,
    this.icon,
  });

  /// This is a required field which would be used to differential between states
  final bool isChecked;

  /// This is the border for state when checkbox is not checked (in its simple inital state)
  final Border? border;

  /// This is variable to change border for checked state
  final Border? checkedBorder;

  /// This variable is to change inner Color for checked state.
  final Color? checkedFillColor;

  /// This variable will return the value when you tap on the button
  final ValueChanged<bool> onTap;

  /// This is to define the size of the checkbox button
  /// The inner icon will expand respectively with the size until the size of icon is separately provided
  final double size;

  /// To define the padding between outer border and inner icon
  final EdgeInsets? innerPadding;

  /// This defines the duration for the animation duration
  final Duration? duration;

  /// This defines the radius for the border
  final double borderRadius;

  /// You can change the inner icon to any other icon as well
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(!isChecked);
      },
      child: AnimatedContainer(
        duration: duration ??
            const Duration(
              milliseconds: 100,
            ),
        height: size,
        width: size,
        decoration: BoxDecoration(
          border: (isChecked ? checkedBorder : border) ?? Border.all(),
          borderRadius: BorderRadius.circular(borderRadius),
          color:
              isChecked ? checkedFillColor ?? Colors.black : Colors.transparent,
        ),
        child: AnimatedSwitcher(
          duration: duration ??
              const Duration(
                milliseconds: 100,
              ),
          child: !isChecked
              ? Container()
              : Center(
                  child: Padding(
                    padding: innerPadding ?? const EdgeInsets.all(2.0),
                    child: icon ??
                        const FittedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                  ),
                ),
        ),
      ),
    );
  }
}
