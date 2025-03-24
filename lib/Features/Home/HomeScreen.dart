import 'dart:io';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/Core/Functions/Navigations.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/Widgets/CustomButton.dart';
import 'package:taskati/Core/Widgets/Header.dart';
import 'package:taskati/Core/Widgets/Header2.dart';
import 'package:intl/intl.dart';
import 'package:taskati/Core/Widgets/task_item.dart';
import 'package:taskati/Features/AddTask/AddTaskScreen.dart';
import 'package:taskati/Features/Completed%20Tasks/CompleteTasksScreen.dart';
import 'package:taskati/Features/Profile/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  Widget build(BuildContext context) {
    var userBox = Hive.box("user");
    String Name = userBox.get("name");
    String Path = userBox.get("image");

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: [
            Header(
              title: "Hello, ${Name}",
              title2: "Have a Nice Day!",
              CutomWidget: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(Path)),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle,
                        size: 30, color: AppColor.WhiteColor),
                    onPressed: () {
                      pushTo(
                          context, ProfileScreen()); // Navigate to Profile page
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Header2(
                // title: DateFormat.yMMMd().format(DateTime.now()),
                // title2: "Today",
                title: DateFormat.yMMMd().format(_selectedDate),
                title2: _selectedDate.day == DateTime.now().day &&
                        _selectedDate.month == DateTime.now().month &&
                        _selectedDate.year == DateTime.now().year
                    ? "Today"
                    : DateFormat('EEEE').format(_selectedDate),
                
                CutomWidget: CustomButton(
                    txt: "+ Add Task",
                    width: 135,
                    onPressed: () {
                      pushTo(context, Addtaskscreen());
                    }),
                    CutomWidgetT: CustomButton(
                    
                    BgColor: AppColor.GreenColor,
                    txt: "Completed Tasks",
                    width: 210,
                    onPressed: () {
                      pushTo(context, CompletedTasksScreen());
                    })),
            SizedBox(
              height: 20,
            ),
            DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColor.PrimaryColor,
              selectedTextColor: Colors.white,
              onDateChange: (Date) {
                setState(() {
                  _selectedDate = Date;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              
                child: ValueListenableBuilder(
              valueListenable: Hive.box('task').listenable(),
              builder: (context, Box taskBox, child) {
                var tasks = taskBox.values.toList();


                var TasksByDate = tasks.where((task) {
                  DateTime taskDate = DateFormat("dd/MM/yyyy").parse(task.Date);
                  return taskDate.year == _selectedDate.year &&
                      taskDate.month == _selectedDate.month &&
                      taskDate.day == _selectedDate.day;
                }).toList();

                return TasksByDate.isEmpty
                    ? Center(
                        child: Text("No tasks for this day !",
                            style: TextStyle(
                              fontSize: 18,
                      )),
                      )

                    : ListView.builder(
                        itemCount: TasksByDate.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            // key: UniqueKey(),
                            // onDismissed: (direction) {
                            //   if (direction == DismissDirection.startToEnd) {
                            //     var task = TasksByDate[index];
                            //     task.IsCompleted = true;
                            //     taskBox.putAt(index, task); // Save updated task to Hive
                            //   } else {
                            //     taskBox.deleteAt(index);
                            //   }
                            // },

                            onDismissed: (direction) {
                              var task = TasksByDate[
                                  index]; // Get the task from filtered list

                              // Find the original index of the task in the taskBox
                              var taskBox = Hive.box('task');
                              int originalIndex =
                                  taskBox.values.toList().indexOf(task);

                              if (originalIndex != -1) {
                                // Ensure task exists in box
                                if (direction == DismissDirection.startToEnd) {
                                  task.IsCompleted = true;
                                  taskBox.putAt(
                                      originalIndex, task); // Update task
                                } else {
                                  taskBox
                                      .deleteAt(originalIndex); // Delete task
                                  print(
                                      "Deleted task at index: $originalIndex");
                                }
                              } else {
                                print("Task not found in Hive!");
                              }

                              setState(() {}); // Refresh UI
                            },
                            // onDismissed: (direction) {
                            //   var task = TasksByDate[index];
                            //   if (direction == DismissDirection.startToEnd) {
                            //     task.IsCompleted = true;
                            //     taskBox.put(task.key, task);
                            //   } else {
                            //     taskBox.delete(task.key);/// No Change
                            //   }
                            //   setState(() {});
                            // },

                            background: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.GreenColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(2, 4),
                                    ),
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: AppColor.WhiteColor,
                                  ),
                                  Text(
                                    "Complete",
                                    style: getSmallTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.RedColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(2, 4),
                                    ),
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: AppColor.WhiteColor,
                                  ),
                                  Text(
                                    "Delete",
                                    style: getSmallTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                            key: UniqueKey(),
                            child: Task_item(
                              task: TasksByDate[index],
                            ),
                          );
                        });
              },
            )),
          ],
        ),
      ),
    ));
  }
}
