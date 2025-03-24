import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/model/TaskAdapter.dart';
import 'package:taskati/Features/Intro/SplashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:device_preview_plus/device_preview_plus.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   Hive.registerAdapter(TaskAdapter());
   await Hive.openBox("user");
   await Hive.openBox("task");

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MainApp(), // Wrap your app
  ),);
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // appBarTheme: AppBarTheme(
        //   backgroundColor: AppColor.PrimaryColor,
        // ),
        //scaffoldBackgroundColor: AppColor.DarkColor,
        inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.PrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.PrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.RedColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.RedColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
      )
      ),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}