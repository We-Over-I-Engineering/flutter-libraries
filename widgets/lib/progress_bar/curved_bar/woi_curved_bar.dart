import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/progress_bar/curved_bar/curved_bar_painter.dart';

/// The [WOICurvedBar] is an arc shape progress bar
///
/// ```dart
/// WOICurvedBar(
/// finalValue: finalValue,
/// currentValue: curentValue,
/// arcBorders: true,
/// padding: 20,
/// size: 220,
/// backgroundBorderRadius: 200,
/// barColor: Colors.grey[300]!,
/// fillColor: Colors.purple,
/// borderColor: Colors.blue[900]!,
/// backgroundColor: Colors.green[200]!,
/// center: Column(
/// mainAxisAlignment: MainAxisAlignment.start,
/// children: [
/// Padding(
/// padding: const EdgeInsets.only(top: 20.0),
/// child: Row(
/// mainAxisAlignment: MainAxisAlignment.center,
/// children: [
/// Text(
/// curentValue.toString(),
/// style: const TextStyle(
///   fontWeight: FontWeight.bold, fontSize: 70),
/// ),
/// const Padding(
/// padding: EdgeInsets.only(bottom: 10),
/// child: Text(
/// '/',
/// style: TextStyle(
///   fontWeight: FontWeight.w200, fontSize: 80),
/// ),
/// ),
/// Text(
/// finalValue.toString(),
/// style: const TextStyle(
///   fontWeight: FontWeight.bold, fontSize: 70),
/// ),
/// ],
/// ),
/// ),
/// const Text(
/// 'Check-Ins',
/// style: TextStyle(fontSize: 16),
/// ),
/// ],
/// ),
/// ),
/// ```
///
/// The [WOISectionBar] takes final value(completion value) and current value(the progress value) as required parameters.

class WOICurvedBar extends StatefulWidget {
  /// The [WOICurvedBar] is an arc shape progress bar
  /// The section bar takes final value(completion value) and current value(the progress value) as required parameters.
  const WOICurvedBar({
    /// This value will mark the completion point of the curved bar.
    required this.finalValue,

    /// This value will indicate the progress fill on the bar.
    required this.currentValue,

    /// This is to display any widget in the center of curved bar.
    this.center = const SizedBox(),

    /// This is the size of the widget.
    /// By default the value is 300.
    this.size = 300,

    /// This is the color of the bar when it is not filled.
    /// By default the color is grey.
    this.barColor = Colors.grey,

    /// This is the color that the arc fills up with as progress increases.
    /// By default it is orange.
    this.fillColor = Colors.orange,

    /// This is the padding between the curved bar and the container that wraps it.
    /// By default the value is 0. It is required if the background color is changed.
    /// Size of the curved bar will change when adding padding so the size of widget will also need changing.
    this.padding = const EdgeInsets.all(0),

    /// This is the background color of the curved bar.
    this.backgroundColor = Colors.white,

    /// This is border radius of the background of the curved bar.
    /// By default the value is 20. This can be used to give the widget a circular shape.
    this.backgroundBorderRadius = 20,

    /// This is the thickness of the curved bar.
    this.arcWidth = 20,

    /// This boolean value is used if the arc needs to be bordered.
    /// By default it is false.
    this.arcBorders = false,

    /// Color of the border in case the arcBorders flag is set to true.
    this.borderColor = Colors.black,

    /// Width of the border in case the arcBorders flag is set to true.
    this.borderWidth = 5,
    super.key,
  }) : assert(currentValue <= finalValue && currentValue >= 0,
            'Current value cannot be greater than final value or less than 0');

  final int finalValue;
  final int currentValue;
  final Widget center;
  final double size;
  final Color barColor;
  final Color fillColor;
  final Color backgroundColor;
  final double backgroundBorderRadius;
  final EdgeInsetsGeometry padding;
  final double arcWidth;
  final bool arcBorders;
  final Color borderColor;
  final double borderWidth;

  @override
  State<WOICurvedBar> createState() => _WOICurvedBarState();
}

class _WOICurvedBarState extends State<WOICurvedBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.backgroundBorderRadius),
      ),
      child: CustomPaint(
        painter: ArcPainter(
          finalValue: widget.finalValue,
          currentValue: widget.currentValue,
          barColor: widget.barColor,
          fillColor: widget.fillColor,
          arcWidth: widget.arcWidth,
          borders: widget.arcBorders,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
        ),
        child: widget.center,
      ),
    );
  }
}
