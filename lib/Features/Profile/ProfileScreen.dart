import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/Core/Functions/Navigations.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/Widgets/CustomButton.dart';
import 'package:taskati/Features/Home/HomeScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? imagePath;
  final ImagePicker picker = ImagePicker();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>(); 

  @override
  void initState() {
    super.initState();
    // Load the current user data from Hive
    _loadUserData();
  }

  // Load user data from Hive
  void _loadUserData() async {
    var userBox = await Hive.openBox('user');
    setState(() {
      name = userBox.get('name');
      imagePath = userBox.get('image');
      nameController.text = name ?? '';
    });
  }

  // Pick an image from the gallery
  void _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  // Function to save the updated data and navigate back to HomeScreen
  void _saveAndNavigateBack() async {
    if (formKey.currentState!.validate() ?? false) {
      if (nameController.text.isNotEmpty && imagePath != null) {
        var userBox = await Hive.openBox('user');
        userBox.put('name', nameController.text);
        userBox.put('image', imagePath);
        pushWithReplacement(context, HomeScreen());
        // // Navigate back to HomeScreen with updated information
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        //   (route) => false, // Removes all the previous routes
        // );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error",
                style: TextStyle(fontSize: 16, color: Colors.red)),
            content: Text(
                "Please make sure to enter a name and upload an image.",
                style: getBodyTextStyle(
                    fontSize: 20, fontWeight: FontWeight.w400)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: getTitleTextStyle(Color: AppColor.WhiteColor, fontSize: 23)),
        backgroundColor: AppColor.PrimaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: imagePath != null
                      ? FileImage(File(imagePath!))
                      : NetworkImage("http://picsum.photos/200")
                          as ImageProvider,
                ),
                SizedBox(height: 20),
                CustomButton(
                  txt: "Change Profile Photo",
                  onPressed: _pickImage,
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 250,
                    child: Form(
                      key: formKey, 
                      child: TextFormField(
                        
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          } else if (!RegExp('^[A-Z][a-z]{2,8}').hasMatch(value)) {
                            return "Name must contain a capital character followed by two to eight lowercase characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.PrimaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.PrimaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextButton(
                  onPressed: _saveAndNavigateBack,
                  child: Text(
                    "Done",
                    style: getSmallTextStyle(
                      Color: AppColor.PrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                ), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
