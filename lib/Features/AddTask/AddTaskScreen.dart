import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati/Core/Functions/Navigations.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/Widgets/CustomButton.dart';
import 'package:taskati/Core/model/TaskModel.dart';
import 'package:taskati/Features/Home/HomeScreen.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});

  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  var formKey = GlobalKey<FormState>();
  var TitleController = TextEditingController();
  var NoteController = TextEditingController();
  var DateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  var StartTimeController =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));

  var EndTimeController =
      TextEditingController(text: DateFormat("hh:mm a").format(DateTime.now()));

  int SelectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: getTitleTextStyle(
            Color: AppColor.WhiteColor,
            fontSize: 23,
          ),
        ),
        backgroundColor: AppColor.PrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: getBodyTextStyle(Color: AppColor.PrimaryColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: TitleController,
                      validator: (value) {
                        if (value != null) {
                          if (value.length < 5) {
                            return "Invalid Title";
                          }
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Note",
                    style: getBodyTextStyle(Color: AppColor.PrimaryColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      maxLines: 4,
                      controller: NoteController,
                      validator: (value) {
                        if (value != null) {
                          if (value.length < 10) {
                            return "Invalid Note";
                          }
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Date",
                    style: getBodyTextStyle(Color: AppColor.PrimaryColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              lastDate: DateTime(2026))
                          .then((value) {
                        if (value != null)
                          DateController.text =
                              DateFormat("dd/MM/yyyy").format(value);
                      });
                    },
                    readOnly: true,
                    controller: DateController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColor.PrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Star Time",
                              style: getBodyTextStyle(
                                Color: AppColor.PrimaryColor,
                                fontSize: 17,
                              ),
                            ),
                            TextField(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  if (value != null)
                                    StartTimeController.text =
                                        value.format(context);
                                });
                              },
                              controller: StartTimeController,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End Time",
                              style: getBodyTextStyle(
                                Color: AppColor.PrimaryColor,
                                fontSize: 17,
                              ),
                            ),
                            TextField(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  if (value != null)
                                    EndTimeController.text =
                                        value.format(context);
                                });
                              },
                              controller: EndTimeController,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  SelectedColor = index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: index == 0
                                    ? AppColor.PrimaryColor
                                    : index == 1
                                        ? AppColor.OrangeColor
                                        : AppColor.RedColor,
                                child: SelectedColor == index
                                    ? Icon(
                                        Icons.check,
                                        color: AppColor.WhiteColor,
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                      Spacer(),
                      CustomButton(
                          txt: "Create Task",
                          width: 150,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Parse time using DateFormat
                              DateFormat format = DateFormat("hh:mm a");
                              DateTime startTime =
                                  format.parse(StartTimeController.text);
                              DateTime endTime =
                                  format.parse(EndTimeController.text);
                              // Validate time
                              // Ensure start time is before end time
                              if (startTime.isAtSameMomentAs(endTime) ||
                                  startTime.isAfter(endTime)) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Center(
                                      child: Text(
                                          "Start time must be before end time!",
                                          style: TextStyle(color: Colors.white), // Text color
                                          ),
                                    ),
                                    backgroundColor: AppColor.PrimaryColor, 
                                    ));
                                return;
                              }

                              TaskModel NewTask = TaskModel(
                                  Id: DateTime.now().toString() +
                                      TitleController.text,
                                  Title: TitleController.text,
                                  Note: NoteController.text,
                                  Date: DateController.text,
                                  StartTime: StartTimeController.text,
                                  EndTime: EndTimeController.text,
                                  Color: SelectedColor,
                                  IsCompleted: false);

                              var taskBox = Hive.box('task');
                              taskBox.put(NewTask.Id, NewTask);

                              pushWithReplacement(context, HomeScreen());
                            }
                          })
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
