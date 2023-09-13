import 'package:flutter/material.dart';
import 'package:weoveri_button/enums.dart';
import 'package:weoveri_button/parallalogram_button/parallalogram_painter.dart';

/// A button that is tilt from sides and accept a `Text` and `icon` in the center
/// `Icons` can be in prefix and sufix
class IconParallalogramButton extends StatelessWidget {
  const IconParallalogramButton({
    Key? key,
    this.onPressed,
    this.buttonColor = Colors.black,
    required this.icon,
    this.iconLocation = WidgetLocation.start,
    this.borderColor,
    this.borderWdth = 1,
    this.margin,
    this.height = 50,
    this.width,
    this.boxShadow,
    this.tilt = 10,
    required this.text,
    this.textStyle,
    this.textMargin,
    this.tiltSide = TiltSide.right,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final WidgetLocation? iconLocation;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final List<BoxShadow>? boxShadow;
  final Color? borderColor;
  final double borderWdth;
  final EdgeInsetsGeometry? margin;
  final double height;
  final double? width;
  final double tilt;
  final TextStyle? textStyle;
  final EdgeInsets? textMargin;
  final TiltSide? tiltSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(boxShadow: boxShadow),
      child: GestureDetector(
        onTap: onPressed!,
        child: CustomPaint(
          painter: MyParallelogram(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Text(
                    text,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
