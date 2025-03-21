import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/Core/Functions/Navigations.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/Widgets/CustomButton.dart';
import 'package:taskati/Features/Home/HomeScreen.dart';

class Uploadscreen extends StatefulWidget {
  const Uploadscreen({super.key});

  @override
  State<Uploadscreen> createState() => _UploadscreenState();
}

class _UploadscreenState extends State<Uploadscreen> {
  String? Path;
  final ImagePicker picker = ImagePicker();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: ()async{
              if(formKey.currentState!.validate() && Path != null){
                var Box = await Hive.openBox('user');
                var UserBox = Hive.box('user');
                UserBox.put('name',nameController.text);
                UserBox.put('image', Path);
                UserBox.put("IsUpoloaded",true);
                //print('Name is ${nameController.text}');
                pushWithReplacement(context, HomeScreen());
              }
              else if( Path == null){
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Error",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),),
                    content: Text("Please Upload Image!",
                    style: getBodyTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )),
                    actions: [
                     TextButton(onPressed: (){
                      Navigator.pop(context);
                     }, 
                     child: Text("Ok"))
                    ],
                  );
                });
              }
            },
             child: Text("Done",
             style:getSmallTextStyle(
              Color: AppColor.PrimaryColor,
              fontSize: 16,
             ),
             ),),
          )
        ],
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
           
            CircleAvatar(
              radius: 70,
              backgroundImage: Path != null
                  ? FileImage(File(Path!))
                  : NetworkImage("http://picsum.photos/200"),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              txt: "Upload From Camera",
              onPressed: () async {
                await ImagePicker()
                    .pickImage(source: ImageSource.camera)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      Path = value.path;
                    });
                    
                  }
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            
            CustomButton(
              txt: "Upload From Gallery",
              onPressed: () async {
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
            
                if (image != null){
                  setState(() {
                      Path = image.path;
                    });
                }
              },
            ),
            
            Divider(
              color: AppColor.PrimaryColor,
              indent: 20,
              endIndent: 20,
              thickness: 2,
            ),
            
            SizedBox(height: 15,),
            
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "Name is required";
                  }
                  else if(!RegExp('^[A-Z][a-z]{2,8}').hasMatch(value))
                  {
                    return "Name must contain a capital character followed by two to eight lowercase characters";
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter Your Name ..",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.PrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.PrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
            )
                    ],
                  ),
          )),
    );
  }
}