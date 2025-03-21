import 'package:flutter/material.dart';
import 'package:taskati/Features/Upload/UploadScreen.dart';

pushTo(BuildContext context, Widget NewScreen){
  Navigator.push(
    context, MaterialPageRoute(builder: (context){
        return NewScreen;
      }
      )
      ,);
}


pushWithReplacement(BuildContext context, Widget NewScreen){
  Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context){
        return NewScreen;
      }
      )
      ,);
}