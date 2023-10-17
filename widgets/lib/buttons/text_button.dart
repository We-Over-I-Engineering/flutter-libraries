import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/buttons/button_style.dart';

/// A simple text button that can be used as a capsule or rectangular button
///
/// Here is how you can use the widget
///
/// ```dart
///
/// WOITextButton(
///   text: 'Submit',
///   onTap: (){},
/// )
/// ```
///
/// ![Text Button](https://github.com/We-Over-I-Engineering/flutter-libraries/assets/85175211/022a3954-94c9-40fb-b226-68d279528488)

class WOITextButton extends StatelessWidget {
  /// The all in one button
  const WOITextButton({
    Key? key,
    this.onTap,
    this.heigth,
    this.width,
    this.isDisabled = false,
    this.buttonStyle,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  /// On Tap action for the Button
  final VoidCallback? onTap;

  /// Define the height of the button
  final double? heigth;

  /// Define the width of the button, by default it would be expanded and
  final double? width;

  /// If the button should be tapable or not
  final bool isDisabled;

  /// This provides multiple option to style your button
  /// Furthure it gives you option to change add `Icons` as a prifix and sufix as well
  final WOIButtonStyle? buttonStyle;

  /// Text String to be displayed
  final String text;

  /// To change the text style for the text
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: _boxDecorator(),
        height: heigth ?? 38,
        width: width ?? width,
        child: _bodyWidgets(),
      ),
    );
  }

  Widget _bodyWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /* (buttonStyle?.widgetLocation ?? WidgetLocation.start) ==
                WidgetLocation.start
            ?  */
        _prefixWidgets(),
        /* : Container(), */
        _textContainer(),
        /* (buttonStyle?.widgetLocation ?? WidgetLocation.start) ==
                WidgetLocation.end
            ?  */
        _sufixWidgets()
        /* : Container(), */
      ],
    );
  }

  Widget _textContainer() {
    if (text == '') {
      return Container();
    }
    return Container(
      margin: buttonStyle?.textMargin,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            const TextStyle(
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  BoxDecoration _boxDecorator() {
    return BoxDecoration(
      color: buttonStyle?.backgroundColor ?? Colors.black,
      borderRadius: buttonStyle?.borderRadius ?? BorderRadius.circular(50),
      border: buttonStyle?.border ??
          Border.all(
            color: Colors.black,
          ),
      gradient: buttonStyle?.gradient,
      boxShadow: buttonStyle?.boxShadow ?? [],
    );
  }

  Widget _prefixWidgets() {
    if (buttonStyle?.prefixWidget != null) {
      return SizedBox(
        child: buttonStyle!.prefixWidget!,
      );
    }
    return Container();
  }

  Widget _sufixWidgets() {
    if (buttonStyle?.sufixWidget != null) {
      return SizedBox(
        child: buttonStyle!.sufixWidget!,
      );
    }
    return Container();
  }
}
