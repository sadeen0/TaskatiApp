import 'package:flutter/material.dart';
import 'package:taskati/Core/Utils/Colors.dart';

TextStyle getTitleTextStyle({double? fontSize, Color? Color, FontWeight? fontWeight} ){
  return TextStyle(
    fontSize: fontSize ?? 30,
    color: Color?? AppColor.PrimaryColor,
    fontWeight: fontWeight?? FontWeight.bold,
  );
}

TextStyle getSmallTextStyle({double? fontSize, Color? Color, FontWeight? fontWeight} ){
  return TextStyle(
    fontSize: fontSize ?? 24,
    color: Color?? AppColor.WhiteColor,
    fontWeight: fontWeight?? FontWeight.bold,
  );
}

TextStyle getBodyTextStyle({double? fontSize, Color? Color, FontWeight? fontWeight} ){
  return TextStyle(
    fontSize: fontSize ?? 16,
    color: Color?? AppColor.DarkColor,
    fontWeight: fontWeight?? FontWeight.bold,
  );
}