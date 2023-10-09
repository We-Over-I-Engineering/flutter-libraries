import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/text_field/woi_text_field_style.dart';

enum TextFieldState {
  initial,
  active,
  approved,
  error,
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
  });

  final WOITextFieldStyle? initialState;
  final WOITextFieldStyle? activeState;
  final WOITextFieldStyle? approvedState;
  final WOITextFieldStyle? errorState;
  final WOITextFieldStyle? disabledState;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onComplete;
  final TextFieldState textFieldState;

  @override
  State<WOITextField> createState() => _WOITextFieldState();
}

class _WOITextFieldState extends State<WOITextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(),
    );
  }
}
