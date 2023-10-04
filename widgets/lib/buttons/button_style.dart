import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/buttons/button_enums.dart';

/// This style class is used to style the [WOITextButton]
/// This has all of the properties to change the appearance of the button
class WOIButtonStyle {
  /// To update the border radius
  BorderRadius? borderRadius;

  /// To provide with the custom border instance
  Border? border;

  /// This is used to provide the side widgets around the text
  Widget? sideWidget;

  /// To provide specific size for the widgets on the sides
  double? sideWidgetSize;

  /// To specify the location for the side widget, for now its only on the left and right
  /// which can specified by [WidgetLocation.end] or [WidgetLocation.start]
  WidgetLocation widgetLocation;

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
    this.sideWidget,
    this.sideWidgetSize,
    this.widgetLocation = WidgetLocation.start,
    this.backgroundColor,
    this.boxShadow,
    this.gradient,
    this.textMargin,
  });
}
