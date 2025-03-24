import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';

class Header2 extends StatelessWidget {
  const Header2(
      {super.key,
      required this.title,
      required this.title2,
      required this.CutomWidget,
      required this.CutomWidgetT});

  final String title, title2;
  final Widget CutomWidget;
  final Widget CutomWidgetT;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: getTitleTextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                title2,
                style: getTitleTextStyle(
                  fontSize: 25,
                ),
              ),
            ]),
            Spacer(),
            CutomWidget
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CutomWidgetT
      ],
    );
  }
}
