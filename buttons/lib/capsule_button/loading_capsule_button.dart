import 'package:flutter/material.dart';

/// An all in one capsule button
class WoiCapsuleLoadingButton extends StatelessWidget {
  const WoiCapsuleLoadingButton({
    Key? key,
    required this.onTap,
    // this.borderRadius = 50,
    this.textStyle,
    this.borderColor,
    this.heigth,
    this.width,
    this.fillColor,
    this.isDisabled = false,
    this.circularProgressSize = 20,
    required this.circularProgressIndicator,
  }) : super(key: key);
  // final double borderRadius;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? heigth;
  final Color? fillColor;
  final double? width;
  final bool isDisabled;
  final CircularProgressIndicator circularProgressIndicator;
  final double circularProgressSize;

  final Color disabledColor = const Color(0xffD9D9D9);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDisabled ? disabledColor : fillColor ?? Colors.black,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isDisabled ? disabledColor : borderColor ?? Colors.black,
          ),
        ),
        height: heigth ?? 38,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _curcularProgressContainer(),
          ],
        ),
      ),
    );
  }

  Widget _curcularProgressContainer() {
    return Container(
        height: circularProgressSize,
        width: circularProgressSize,
        child: circularProgressIndicator);
  }
}
