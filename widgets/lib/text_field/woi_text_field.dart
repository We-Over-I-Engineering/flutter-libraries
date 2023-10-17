import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weoveri_flutter_widgets/text_field/text_field_enum.dart';
import 'package:weoveri_flutter_widgets/text_field/woi_text_field_style.dart';

/// A text field following material design
///
/// Here is the simple version that can be used:
/// All of the fields in the widget are optional so by default it will only show a textfield
/// with bit rounded corners without reflecting any information.
///
///
///```dart
///WOITextField(
///   border: OutlineInputBorder(
///     borderSide: BorderSide(
///       color: Color(0xff007EDA),
///     ),
///     borderRadius: BorderRadius.all(
///       Radius.circular(6),
///     ),
///   ),
///   labelText: 'Email Address',
///   helperText: 'Make sure it is valid',
///   hintText: 'Placeholder Text',
///   prefixIcon: Icon(
///     Icons.email_outlined,
///     color: Color(0xff007EDA),
///   ),
///   hintTextStyle: TextStyle(
///     color: Color(0xffB6A8A8),
///     fontSize: 18,
///   ),
/// ),
/// ```
///
///---
/// Here is how that would look with the above code
///
///![Simple version of WOITextField](https://github.com/We-Over-I-Engineering/flutter-libraries/assets/85175211/d22f4d57-b3f6-4df1-a000-9154ca54be0a)
///
///
///
///---
/// In the Widget there would be 5 types of states that can be changed based on the enum [TextFieldState],
///
/// The initial state would be set to [TextFieldState.initial].
///
/// Now you can change the states and then add specific customization based on the states
///
/// Futher there are 2 fields that can be deafult or customizable based on the states
///
/// These are [border] and [textStyle]. Now if values are provided in those variables
/// and they are not reassigned in the states style then the value in these variable will be used everywhere
/// except for the error state
///
/// The [TextFieldState.error] is the only state with already some different values like the `text` and `border color` and
/// `helper text color` becomes red by default but can be set by providing different values to [errorState] variable
/// using the [WOITextFieldStyle] style class
///
///
/// Now lets create a complex variation of the text field while utalizing its many fields
/// So that would look something like below with the following code
///
///---
///
///![Input Field With Error State](https://github.com/We-Over-I-Engineering/flutter-libraries/assets/85175211/288abeb6-807d-4c99-9882-3c5bb7f3340b)
///
///---
///```dart
/// WOITextField(
///   labelText: 'Email Address',
///   helperText: 'Invalid email',
///   textFieldState: TextFieldState.error,
///   errorState: WOITextFieldStyle(
///     helperTextStyle: const TextStyle(
///       color: Color(0xffCD3843),
///     ),
///     textBorders: const OutlineInputBorder(
///       borderSide: BorderSide(
///         color: Color(0xffCD3843),
///       ),
///     ),
///     textStyle: const TextStyle(
///       color: Color(0xffCD3843),
///       fontSize: 18,
///     ),
///   ),
///   prefixIcon: const Icon(
///     Icons.email_outlined,
///     color: Color(0xffCD3843),
///   ),
///   suffixIcon: const Icon(
///     Icons.cancel,
///     color: Color(0xffCD3843),
///   ),
/// ),
/// ```

class WOITextField extends StatefulWidget {
  const WOITextField({
    super.key,
    this.initialState,
    this.activeState,
    this.completedState,
    this.errorState,
    this.disabledState,
    this.onChange,
    this.onSubmitted,
    this.textFieldState = TextFieldState.initial,
    this.labelTextStyle,
    this.fieldContainerMargin,
    this.textInputType,
    this.textEditingController,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.hintTextStyle,
    this.hintText = '',
    this.labelText = '',
    this.helperText = '',
    this.onTap,
    this.border,
    this.textStyle,
    this.cursorColor,
    this.inputFormatters,
    this.showCursor = true,
    this.boxShadow,
  });

  /// initial default state
  final WOITextFieldStyle? initialState;

  /// That's the state that would show when use taps on the text field to add some value
  final WOITextFieldStyle? activeState;

  /// A state that define the completed state
  final WOITextFieldStyle? completedState;

  /// A state that would come up in case of error, it already have some default value which include the colors to red
  final WOITextFieldStyle? errorState;

  /// A state to define the disable state of the text field
  final WOITextFieldStyle? disabledState;

  /// onChange call back that would return current string
  final ValueChanged<String>? onChange;

  /// onSubmitted call back that triggers after check icon from the keyboard
  final ValueChanged? onSubmitted;

  /// State enum variable
  final TextFieldState textFieldState;

  /// label text style
  final TextStyle? labelTextStyle;

  /// Margins around the text field container that would come between label and helper text
  final EdgeInsets? fieldContainerMargin;

  /// Input Text Type
  final TextInputType? textInputType;

  /// Editing controller for the text field
  final TextEditingController? textEditingController;

  /// Text field fill Color, by deafult it would be transparent
  final Color? fillColor;

  /// Suffix Widget
  final Widget? suffixIcon;

  /// Prefix Widget
  final Widget? prefixIcon;

  /// Placeholder Hint Text Style
  final TextStyle? hintTextStyle;

  /// Placeholder Hint Text
  final String hintText;

  /// Text for Label as that would show up in the header
  final String labelText;

  /// The helper text that would show up at the bottom left side
  final String helperText;

  /// On tap function that will trigger by tapping on textfield
  final Function? onTap;

  /// The detaul border for all states except error state and can be changed with style class
  final InputBorder? border;

  /// This is the deafult text style for the text field value but can be changed based on the state
  final TextStyle? textStyle;

  /// To define the cursor color
  final Color? cursorColor;

  /// To add custom input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// to show/hide the cursor in the textfield, will be set to `true` by deafult
  final bool showCursor;

  /// Shadow for the Text field, that will only be applied to the text field inter container
  final List<BoxShadow>? boxShadow;

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
              widget.labelText,
              style: widget.labelTextStyle ??
                  const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        Padding(
          padding: widget.fieldContainerMargin ?? const EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: widget.boxShadow,
            ),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: _inputBorder(),
                filled: widget.fillColor != null ? true : false,
                fillColor: widget.fillColor,
                focusedBorder: widget.activeState?.textBorders ??
                    widget.border ??
                    const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                errorBorder: widget.errorState?.textBorders ??
                    widget.border ??
                    const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                focusedErrorBorder: widget.errorState?.textBorders ??
                    widget.border ??
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
              cursorColor: widget.cursorColor,
              showCursor: widget.showCursor,
              inputFormatters: widget.inputFormatters,
              onChanged: (value) {
                widget.onChange!(value);
              },
              onSubmitted: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
                widget.onSubmitted!(value);
              },
              onTap: () {
                widget.onTap!();
              },
              style: _controllerTextStyle(),
              keyboardType: widget.textInputType,
              enabled: widget.textFieldState != TextFieldState.disabled,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              widget.helperText,
              style: _helperTextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  /// This returns the textStyle for the String value of text field based on the current
  /// state selected or if default [textStyle] is provided
  TextStyle _controllerTextStyle() {
    TextStyle textStyle = widget.textStyle ??
        const TextStyle(
          // fontSize: 14,
          color: Colors.black,
        );

    switch (widget.textFieldState) {
      case TextFieldState.initial:
        return widget.initialState?.textStyle ?? textStyle;
      case TextFieldState.active:
        return widget.activeState?.textStyle ?? textStyle;

      case TextFieldState.completed:
        return widget.completedState?.textStyle ?? textStyle;

      case TextFieldState.disabled:
        return widget.disabledState?.textStyle ?? textStyle;
      case TextFieldState.error:
        return widget.errorState?.textStyle ??
            const TextStyle(
              color: Colors.red,
            );

      default:
        return textStyle;
    }
  }

  /// This returns the textStyle for the helper text string based on the current
  /// state selected default would be set to [Colors.black]
  TextStyle _helperTextStyle() {
    TextStyle textStyle = const TextStyle(
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
        return widget.errorState?.helperTextStyle ??
            const TextStyle(
              color: Colors.red,
            );

      default:
        return textStyle;
    }
  }

  /// This returns the border for the text field based on the current
  /// state selected or if default [border] is provided
  InputBorder _inputBorder() {
    InputBorder textBorder = widget.border ?? const OutlineInputBorder();
    if (widget.textFieldState == TextFieldState.initial) {
      return widget.initialState?.textBorders ?? textBorder;
    }
    if (widget.textFieldState == TextFieldState.active) {
      return widget.activeState?.textBorders ??
          widget.border ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          );
    }
    if (widget.textFieldState == TextFieldState.completed) {
      return widget.completedState?.textBorders ??
          widget.border ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          );
    }
    if (widget.textFieldState == TextFieldState.disabled) {
      return widget.disabledState?.textBorders ??
          widget.border ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          );
    }
    if (widget.textFieldState == TextFieldState.error) {
      return widget.border ??
          widget.errorState?.textBorders ??
          const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          );
    }
    return widget.initialState?.textBorders ?? textBorder;
  }
}
