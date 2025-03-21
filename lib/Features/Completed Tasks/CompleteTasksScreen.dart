import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/Widgets/task_item.dart';
import 'package:intl/intl.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  bool _showAllCompletedTasks = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Completed Tasks",
          style: getTitleTextStyle(
            Color: AppColor.WhiteColor,
            fontSize: 23,
          ),
        ),
        backgroundColor: AppColor.PrimaryColor,
        actions: [
          Switch(
            value: _showAllCompletedTasks,
            inactiveThumbColor: AppColor.PrimaryColor,
            activeColor: AppColor.WhiteColor,
            inactiveTrackColor: AppColor.WhiteColor,
            onChanged: (value) {
              setState(() {
                _showAllCompletedTasks = value;
              });
            },
          ),

          SizedBox(width: 5,),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Text(
              _showAllCompletedTasks ? "All" : "Today",
              style: TextStyle(
              color: AppColor.WhiteColor,
              fontWeight: FontWeight.bold,
               fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('task').listenable(),
          builder: (context, Box taskBox, child) {
            var tasks = taskBox.values.toList();
            var completedTasks =
                tasks.where((task) => task.IsCompleted).toList();

            // Filter only today's completed tasks(showAll.. = false)
            if (!_showAllCompletedTasks) {
              completedTasks = completedTasks.where((task) {
                DateTime taskDate = DateFormat("dd/MM/yyyy").parse(task.Date);
                DateTime today = DateTime.now();

                
                return taskDate.year == today.year &&
                    taskDate.month == today.month &&
                    taskDate.day == today.day;
              }).toList();
            }

            
            if (completedTasks.isEmpty) {
              return Center(
                child: Text(
                  "No completed tasks Yet",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return Task_item(task: completedTasks[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
