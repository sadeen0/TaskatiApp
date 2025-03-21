import 'package:flutter/material.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? BgColor;
  final Color? txtColor;
  final String txt;
  final Function() onPressed;

  const CustomButton({
    super.key,
    this.width = 250,
    this.height = 50,
    required this.txt,
    this.BgColor,
    this.txtColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed, 
      child: Text(txt,
      style: getBodyTextStyle(
      Color: txtColor ?? AppColor.WhiteColor
      ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: BgColor ?? AppColor.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      ),
    );
  }
}