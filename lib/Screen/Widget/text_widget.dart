import 'package:exercise_app/Const/local_color.dart';
import 'package:flutter/material.dart';




Widget text(String text,
    {double fontSize = 14,
      textColor = textColorPrimary,
      //var fontFamily = LocalFont.fontFamilySFPro,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.5}) {
  return Text(
    text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        //fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing),
  );
}


Widget boldtext(String text,
    {double fontSize = 16,
      textColor = textColorPrimary,
      //var fontFamily = LocalFont.fontFamilySFPro,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.5}) {
  return Text(
    text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        //fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        fontWeight: FontWeight.bold,
        letterSpacing: latterSpacing),
  );
}
