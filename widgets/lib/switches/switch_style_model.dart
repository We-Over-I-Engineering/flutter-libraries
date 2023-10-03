import 'package:flutter/material.dart';

/// If you want to explore the full extent of the `WOISwitchButton` then
/// we have the active and inactive states for the swtich as well which you can change
/// using the following model by providing the value for the `activeSwitchStyle`
/// and `inActiveSwitchStyle` fields while both of them accepts the
/// `WOISwitchStyleModel` type value which is a custom model for styling of the widget

class WOISwitchStyleModel {
  /// To change the color for the thumb
  final Color? thumbColor;

  /// To change the color for the track
  final Color? trackColor;

  /// To change and customize the border for the thumb
  final Border? thumbBorder;

  /// To change and customize the border for the track
  final Border? trackBorder;

  /// To change the size of the thumb initially that will be set to 25 for both states
  final double thumbSize;

  /// To provide a icon in the center for the thumb
  final Icon? icon;

  WOISwitchStyleModel({
    this.thumbSize = 25,
    this.icon,
    this.thumbBorder,
    this.thumbColor,
    this.trackBorder,
    this.trackColor,
  });
}
