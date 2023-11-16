import 'package:flutter/material.dart';

/// A widget that gives you option to toggle between 2 values as a radio button
///
/// Here is the very basic way to use the widget
/// ```dart
///WOIRadioButton(
///   isSelected: radioValue,
///   onTap: (bool isSelected) {
///     radioValue = isSelected;
///     setState(() {});
///   },
/// )
/// ```
///
/// The `isSelected` and `onTap` are required fields
/// `onTap` field will return the data when ever the value is changed with the updated value on what should be the new value after the tap action
///
///
///
///
/// Furthure if you want to explore the full extent of the widget then we have the selected and non selected states for the radio button
/// so to customize the radio button in its selected state there would be variables
/// starting from 'selected' or would have 'selected' in them
///
///
///
///
/// Here is the implementation with all utalization of its customization
/// ```dart
/// WOIRadioButton(
///   isSelected: radioValue,
///   onTap: (bool isSelected) {
///     radioValue = isSelected;
///     setState(() {});
///   },
///   border: Border.all(
///     color: Colors.green,
///     width: 2,
///   ),
///   selectedBorder: Border.all(
///     color: Colors.black,
///   ),
///   selectedFillColor: Colors.black,
///   size: 30,
///   innerPadding: const EdgeInsets.all(3),
///   duration: const Duration(
///     milliseconds: 1,
///   ),
/// ),
/// ```

class WOIRadioButton extends StatelessWidget {
  const WOIRadioButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.border,
    this.selectedBorder,
    this.selectedFillColor,
    this.size = 25,
    this.innerPadding,
    this.duration,
    this.backgroundColor,
  });

  /// This is a required field which would be used to differential between states
  final bool isSelected;

  /// This is the border for state when radio button is not selected
  final Border? border;

  /// This is variable to change border for selected state
  final Border? selectedBorder;

  /// This is variable to change inner Color for selected state. The inner filled cirle
  final Color? selectedFillColor;

  /// This variable will return the value when you tap on the button
  final ValueChanged<bool> onTap;

  /// This is to define the size of the radio button
  /// The inner circle will expand with the size of outer widget
  final double size;

  /// To define the padding between outer cirlce and inner circle
  final EdgeInsets? innerPadding;

  /// This defines the duration for the animation duration
  final Duration? duration;

  /// This defines the background Color
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(!isSelected);
      },
      child: AnimatedContainer(
        duration: duration ??
            const Duration(
              milliseconds: 100,
            ),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: (isSelected ? selectedBorder : border) ?? Border.all(),
          borderRadius: BorderRadius.circular(100),
        ),
        child: AnimatedSwitcher(
          duration: duration ??
              const Duration(
                milliseconds: 100,
              ),
          child: !isSelected
              ? Container()
              : Padding(
                  padding: innerPadding ?? const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedFillColor ?? Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
