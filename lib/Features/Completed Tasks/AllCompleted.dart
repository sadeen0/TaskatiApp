import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/Widgets/task_item.dart'; 

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Tasks", 
          style: getTitleTextStyle(
            Color: AppColor.WhiteColor,
            fontSize: 23,
          ),),
        backgroundColor: AppColor.PrimaryColor, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('task').listenable(),
          builder: (context, Box taskBox, child) {
            // Get all tasks from Hive
            var tasks = taskBox.values.toList();

            // Filter completed tasks 
            var completedTasks = tasks.where((task) => task.IsCompleted).toList();

            if (completedTasks.isEmpty) {
              return Center(
                child: Text("No completed tasks yet", 
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.GreyColor),
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