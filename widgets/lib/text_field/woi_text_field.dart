import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/text_field/woi_text_field_style.dart';

enum TextFieldState {
  initial,
  active,
  approved,
  error,
  disabled,
}

class WOITextField extends StatefulWidget {
  const WOITextField({
    super.key,
    this.initialState,
    this.activeState,
    this.approvedState,
    this.errorState,
    this.disabledState,
    this.onChange,
    this.onComplete,
    this.textFieldState = TextFieldState.initial,
    this.borders,
    this.labelTextStyke,
    this.textFieldMargin,
    this.isFilled,
    this.textInputType,
    this.textEditingController,
  });

  final WOITextFieldStyle? initialState;
  final WOITextFieldStyle? activeState;
  final WOITextFieldStyle? approvedState;
  final WOITextFieldStyle? errorState;
  final WOITextFieldStyle? disabledState;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onComplete;
  final TextFieldState textFieldState;
  final InputBorder? borders;
  final TextStyle? labelTextStyke;
  final EdgeInsets? textFieldMargin;
  final bool? isFilled;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;

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
              style: widget.labelTextStyke ??
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
              border: widget.borders ?? const OutlineInputBorder(),
              filled: widget.isFilled,
              hintText: 'hellow there',
            ),
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            enabled: widget.textFieldState != TextFieldState.disabled,
          ),
        ),
        Row(
          children: [
            Text(
              'helperText',
              style: widget.labelTextStyke ??
                  const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
