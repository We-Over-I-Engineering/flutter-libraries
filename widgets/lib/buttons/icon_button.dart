import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/buttons/button_style.dart';

/// A square button with the Icon in center
/// the border radius of the button can be changed making it to the circular button by
/// providing specific value to [borderRadius] variable
/// Here is how you can use the widget:
///
/// ```dart
///
/// WOIIconButton(
///   child: Icon( Icons.percent, color: Colors.white, ),
///   onTap: () {},
/// )
/// ```
///
/// You can change the icon color and other properties accordingly
class WOIIconButton extends StatelessWidget {
  ///Size for the Icon
  final double size;

  ///Backgound Color around the Icon
  final Color backgroundColor;

  /// Border of the Icon button
  final Border? border;

  /// Shadow for the button
  final List<BoxShadow>? boxShadow;

  ///to let know if the button should be clickable or not
  final bool isDisabled;

  ///Tap action for the button on what to happen
  final Function? onTap;

  /// Border radisu for the button
  final BorderRadius? borderRadius;

  /// If you want to add some custom child of the icon button like `Text`
  final Widget? child;

  final WOIButtonStyle? buttonStyle;

  /// An Icon button with custom border radius
  ///
  /// Atleast one field in `icon` or `child` is required
  const WOIIconButton({
    Key? key,
    this.size = 35,
    this.backgroundColor = Colors.black,
    this.border,
    this.boxShadow,
    this.borderRadius,
    this.isDisabled = false,
    required this.onTap,
    this.child,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled
          ? null
          : () {
              if (isDisabled) {
                return;
              }
              onTap!();
            },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: child ?? Container(),
        ),
      ),
    );
  }
}
