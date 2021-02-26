import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final text;
  final onPressed;
  final textColor;
  final buttonColor;

  RectangularButton({
    @required this.text,
    @required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: this.buttonColor,
      textColor: this.textColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: buttonTextStyle,
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
