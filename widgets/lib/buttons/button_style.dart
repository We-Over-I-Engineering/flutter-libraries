import 'package:flutter/material.dart';

/// This style class is used to style the [WOITextButton]
/// This has all of the properties to change the appearance of the button
class WOIButtonStyle {
  /// To update the border radius
  BorderRadius? borderRadius;

  /// To provide with the custom border instance
  Border? border;

  /// This is used to provide the prefix widget before the text
  Widget? prefixWidget;

  /// This is used to provide the sufix widget after the text
  Widget? sufixWidget;

  /// To speficy a color of the button
  Color? backgroundColor;

  /// To Provide the custom box shadow list for the button
  List<BoxShadow>? boxShadow;

  /// This is to provide gradient value in the button
  /// The priority for this is more then the background Color
  /// So if both [backgroundColor] and [gradient] is provided then it will go with the [gradient]
  Gradient? gradient;

  /// To specify margins around the text widget that is in the center
  EdgeInsets? textMargin;
  WOIButtonStyle({
    this.borderRadius,
    this.border,
    this.prefixWidget,
    this.sufixWidget,
    this.backgroundColor,
    this.boxShadow,
    this.gradient,
    this.textMargin,
  });
}
