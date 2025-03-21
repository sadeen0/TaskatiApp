import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/Core/Functions/Navigations.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Features/Home/HomeScreen.dart';
import 'package:taskati/Features/Upload/UploadScreen.dart';

class Splashscreen extends StatefulWidget {
   Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState(){
    super.initState();
    var UserBox = Hive.box('user');

    bool IsUpoloaded  = UserBox.get("IsUpoloaded") ?? false;
    Future.delayed(Duration(seconds:3), (){
      if (IsUpoloaded){
        pushWithReplacement(context, HomeScreen());
      }
      else{
        pushWithReplacement(context, Uploadscreen());
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('./assets/images/logo.json'),
            Text("Taskati",
            style: getTitleTextStyle()
            ),
            Text("It's time to get organized!",
            style: getBodyTextStyle()
            ), 
          ],
        ),
      ),
    );
  }
}