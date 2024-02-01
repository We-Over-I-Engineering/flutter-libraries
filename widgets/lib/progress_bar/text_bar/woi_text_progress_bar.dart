import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/progress_bar/text_bar/text_bar_painter.dart';

/// The [WOITextBar] is a progress bar variation that has a text depicting progress which fills up based on the progress value.
///
/// Here is an example of the [WOITextBar]
///
/// ```dart
/// const SizedBox(
///       child: WOITextBar(
///         progressValue: 10,
///         tiltValue: 0,
///         borderRadius: 30,
///         textStyle: TextStyle(
///           fontSize: 150,
///           fontWeight: FontWeight.bold,
///           height: 0,
///         ),
///         boxBackgroundColor: Colors.red,
///         fillColor: Colors.orange,
///         textColor: Colors.black,
///       ),
///     ),
/// ```
///
/// The size of the [WOITextBar] is adjusted by the font size of the widget.
/// The progress value is a required field and should be between 0 and 100 inclusive.

class WOITextBar extends StatefulWidget {
  /// Styling of the text. To change color of the text use [WOITextBar]'s textColor property.
  final TextStyle textStyle;

  /// Change color of the background of the widget. By default the color is yellow.
  final Color boxBackgroundColor;

  /// This is the color that fills up the text as the progress value increases.
  final Color fillColor;

  /// This is a required field that changes the progress being tracked by the [WOITextBar].
  final int progressValue;

  /// Tilt value changes the tilt of the fill color. By default value is 0 which means no tilt. Negative value will give right tilt and positive value will give left tilt.
  final int tiltValue;

  /// This is used to change the color of the text.
  final Color textColor;

  /// This changes the border radius of the background of the [WOITextBar]. It cannot be more than 30.
  final double borderRadius;

  /// The [WOITextBar] is a progress bar variation that has a text depicting progress which fills up based on the progress value.
  /// It takes an interger progressValue as a required parameter which should be between 0 and 100 inclusive. Border radius can not be more than 30
  const WOITextBar({
    super.key,
    this.textStyle = const TextStyle(
      fontSize: 150,
      fontWeight: FontWeight.bold,
      height: 0,
    ),
    this.boxBackgroundColor = Colors.yellow,
    this.fillColor = Colors.blueAccent,
    required this.progressValue,
    this.tiltValue = 0,
    this.textColor = Colors.black,
    this.borderRadius = 20,
  })  : assert(progressValue >= 0 && progressValue <= 100,
            "Progress value should be between 0 and 100 inclusive"),
        assert(borderRadius <= 30, "Border radius should be less than 30");
  @override
  State<WOITextBar> createState() => _WOITextBarState();
}

class _WOITextBarState extends State<WOITextBar> {
  bool isTilt = true;

  @override
  Widget build(BuildContext context) {
    String textValue = widget.progressValue.toString();
    if (textValue.length == 1) {
      textValue = '0${widget.progressValue.toString()}';
    }
    if (widget.progressValue == 0 || widget.progressValue == 100) {
      isTilt = false;
    } else {
      isTilt = true;
    }
    final textPainter = TextPainter(
      text: TextSpan(
        text: textValue,
        style: widget.textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: double.infinity);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: widget.textColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: CustomPaint(
              size: Size(
                textPainter.size.width,
                textPainter.size.height - (textPainter.size.height * .35),
              ),
              painter: TextFillPainter(
                fillColor: widget.fillColor,
                progressValue: widget.progressValue / 100,
                tiltValue: isTilt ? widget.tiltValue : 0,
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: ShaderMask(
            blendMode: BlendMode.srcOut,
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                widget.boxBackgroundColor.withOpacity(1),
              ],
              stops: const [0.0],
            ).createShader(bounds),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: Colors.white.withOpacity(0.01),
              ),
              height: textPainter.size.height,
              child: Text(
                textValue,
                textAlign: TextAlign.center,
                style: widget.textStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
