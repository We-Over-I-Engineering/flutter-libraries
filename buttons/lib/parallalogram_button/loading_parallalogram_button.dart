import 'package:flutter/material.dart';
import 'package:weoveri_button/enums.dart';
import 'package:weoveri_button/parallalogram_button/parallalogram_painter.dart';

/// A button that is tilt from sides and accept a `Text` and `loadingProgressIndicator` in the center
/// `loadingProgressIndicator` can be in prefix and sufix
class LoadingParallalogramButton extends StatelessWidget {
  const LoadingParallalogramButton({
    Key? key,
    this.onPressed,
    this.buttonColor = Colors.black,
    required this.loadingProgressIndicator,
    this.iconLocation = WidgetLocation.start,
    this.indicatorSize = 24,
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
    this.indicatorMargin,
  }) : super(key: key);

  final String text;
  final CircularProgressIndicator loadingProgressIndicator;
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
  final double? indicatorSize;
  final EdgeInsets? indicatorMargin;

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
                  Container(
                    height: indicatorSize,
                    width: indicatorSize,
                    margin: indicatorMargin,
                    child: loadingProgressIndicator,
                  ),
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
