import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/buttons/parallalogram_painter.dart';

import '../utils/enums.dart';

/// A button that is tilt from sides and accept a `Text` in the center
///
/// Here is how you can use the widget
///
/// ```dart
///
/// WOIParallalogramButton(
///   text: "Parallalogram Button",
///   onPressed: () {},
/// )
/// ```

class WOIParallalogramButton extends StatelessWidget {
  const WOIParallalogramButton({
    Key? key,
    this.onPressed,
    this.buttonColor = Colors.black,
    this.borderColor,
    this.borderWdth = 1,
    this.height = 50,
    this.width,
    this.boxShadow,
    this.tilt = 10,
    required this.text,
    this.textStyle,
    this.textMargin,
    this.tiltSide = TiltSide.right,
  }) : super(key: key);

  /// Required Field that will display text in the center
  final String text;

  /// Handle tap/press action on the button
  final VoidCallback? onPressed;

  /// Change button color by default its [Colors.white]
  final Color buttonColor;

  /// Provide custom shadow to the button
  final List<BoxShadow>? boxShadow;

  /// Change/update border color
  final Color? borderColor;

  /// To provide the border width for the button
  final double borderWdth;

  /// To provide the specific height of the button
  final double height;

  /// To provide the specific height of the button
  final double? width;

  /// This is to change the value for the tilt ranging from 20 to 50
  final double tilt;

  /// This is used to change the text for the text
  final TextStyle? textStyle;

  /// This is to update the text margin around the text
  final EdgeInsets? textMargin;

  /// This variables handles the tile side of the button from left or right
  /// Can be [TiltSide.left] or [TiltSide.right]
  final TiltSide? tiltSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        gradient: const LinearGradient(
          colors: [
            Colors.black,
            Colors.white,
            Colors.blue,
          ],
        ),
      ),
      child: GestureDetector(
        onTap: onPressed!,
        child: CustomPaint(
          painter: WOIParallelogramPainter(
            tilt: tiltSide == TiltSide.right ? tilt : -tilt,
            borderColor: borderColor ?? buttonColor,
            borderWidth: borderWdth,
            buttonColor: buttonColor,
          ),
          child: Center(
            child: Padding(
              padding: textMargin ??
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
              child: Text(
                text,
                style: textStyle ??
                    const TextStyle(
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
