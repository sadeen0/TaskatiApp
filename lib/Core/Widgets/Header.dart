import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    required this.title2,
    required this.CutomWidget,
  });

  final String title, title2;
  final Widget CutomWidget;

  @override
  Widget build(BuildContext context) {
    return Row(                 
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
            style: getTitleTextStyle(
              //Color: AppColor.WhiteColor,
              fontSize: 20,
            ),
            ),
            Text(title2,
            style: getTitleTextStyle(
              //Color: AppColor.WhiteColor,
              fontSize: 25,
            ),), 
            ]
            ),
            
            Spacer(),
            
            CutomWidget,
      ],
    );
  }
}