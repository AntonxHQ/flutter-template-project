import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:flutter/material.dart';

class AuthMessage extends StatelessWidget {
  final String text;
  final String authText;
  final Function onPressed;
  AuthMessage({this.text, this.authText, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("$text have an account?", textAlign: TextAlign.center,style: subHeadingTextStyle.copyWith(fontSize: 14),),
      SizedBox(width: 10,),
      InkWell(
          onTap: onPressed,
          child: Text(" $authText", style: subHeadingTextStyle.copyWith(fontSize: 14, color: primaryColor),))
      ],
    );
//    return RichText(
//        text: TextSpan(
//            text: "$text have an account?",
//            style: subHeadingTextStyle.copyWith(fontSize: 14),
//            children: [
//              TextSpan(
//                text: " $authText",
//                style: subHeadingTextStyle.copyWith(fontSize: 14, color: primaryColor),
//              )
//            ]
//        ));
  }
}
