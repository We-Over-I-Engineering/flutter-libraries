import 'package:flutter/material.dart';

/// A style class for decorating different states for the WOITextField
///
/// WOITextfield has different states which can be changed with the following style class

class WOITextFieldStyle {
  TextStyle? hintTextStyle;
  Widget? leftIcon;
  Widget? rightIcon;
  TextStyle? helperTextStyle;
  InputBorder? textBorders;
  TextStyle? textStyle;

  WOITextFieldStyle({
    this.hintTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.helperTextStyle,
    this.textBorders,
    this.textStyle,
  });
}
