import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/text_field/woi_text_field_style.dart';

enum TextFieldState {
  initial,
  active,
  completed,
  error,
  disabled,
}

class WOITextField extends StatefulWidget {
  const WOITextField({
    super.key,
    this.initialState,
    this.activeState,
    this.completedState,
    this.errorState,
    this.disabledState,
    this.onChange,
    this.onComplete,
    this.textFieldState = TextFieldState.initial,
    this.labelTextStyle,
    this.textFieldMargin,
    this.textInputType,
    this.textEditingController,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.hintTextStyle,
    this.hintText,
  });

  // States variables
  final WOITextFieldStyle? initialState;
  final WOITextFieldStyle? activeState;
  final WOITextFieldStyle? completedState;
  final WOITextFieldStyle? errorState;
  final WOITextFieldStyle? disabledState;

  // onChange call back
  final ValueChanged<String>? onChange;
  // onComplete call back
  final ValueChanged<String>? onComplete;

  // State Variable
  final TextFieldState textFieldState;

  // Header label text style
  final TextStyle? labelTextStyle;

  // Text field margins
  final EdgeInsets? textFieldMargin;

  // Input Text Type
  final TextInputType? textInputType;

  // Controller
  final TextEditingController? textEditingController;

  // Fill Color
  final Color? fillColor;

  // Suffix Icon
  final Icon? suffixIcon;

  // Prefix Icon
  final Icon? prefixIcon;

  // Placeholder Hint Text Style
  final TextStyle? hintTextStyle;

  // Placeholder Hint Text Value
  final String? hintText;

  @override
  State<WOITextField> createState() => _WOITextFieldState();
}

class _WOITextFieldState extends State<WOITextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              'Label Text',
              style: widget.labelTextStyle ??
                  const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        Padding(
          padding: widget.textFieldMargin ?? const EdgeInsets.all(0.0),
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: _inputBorder(),
              filled: widget.fillColor != null ? true : false,
              fillColor: widget.fillColor,
              focusedBorder: widget.activeState?.textBorders ??
                  const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
              errorBorder: widget.errorState?.textBorders ??
                  const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
              focusedErrorBorder: widget.errorState?.textBorders ??
                  const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
            ),
            controller: widget.textEditingController,
            onChanged: (value) {
              widget.onChange!(value);
            },
            onEditingComplete: () {
              widget.onComplete!(widget.textEditingController!.text);
            },
            style: const TextStyle(),
            keyboardType: widget.textInputType,
            enabled: widget.textFieldState != TextFieldState.disabled,
          ),
        ),
        Row(
          children: [
            Text(
              'helperText',
              style: _helperTextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle _helperTextStyle() {
    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    );

    switch (widget.textFieldState) {
      case TextFieldState.initial:
        return widget.initialState?.helperTextStyle ?? textStyle;
      case TextFieldState.active:
        return widget.activeState?.helperTextStyle ?? textStyle;

      case TextFieldState.completed:
        return widget.completedState?.helperTextStyle ?? textStyle;

      case TextFieldState.disabled:
        return widget.disabledState?.helperTextStyle ?? textStyle;
      case TextFieldState.error:
        return widget.errorState?.helperTextStyle ?? textStyle;

      default:
        return textStyle;
    }
  }

  InputBorder _inputBorder() {
    OutlineInputBorder textBorder = const OutlineInputBorder();
    if (widget.textFieldState == TextFieldState.initial) {
      return widget.initialState?.textBorders ?? textBorder;
    }
    if (widget.textFieldState == TextFieldState.active) {
      return widget.activeState?.textBorders ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          );
    }
    if (widget.textFieldState == TextFieldState.completed) {
      return widget.completedState?.textBorders ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          );
    }
    if (widget.textFieldState == TextFieldState.disabled) {
      return widget.disabledState?.textBorders ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          );
    }
    if (widget.textFieldState == TextFieldState.error) {
      return const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      );
    }
    return widget.initialState?.textBorders ?? textBorder;
  }
}
