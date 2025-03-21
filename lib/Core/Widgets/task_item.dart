import 'package:flutter/material.dart';
import 'package:taskati/Core/Utils/Colors.dart';
import 'package:taskati/Core/Utils/TextStyle.dart';
import 'package:taskati/Core/model/TaskModel.dart';

class Task_item extends StatelessWidget {
  final TaskModel task;
  
  const Task_item({
    super.key,
    required this.task,
    
  });

  @override
  Widget build(BuildContext context) {
     Color taskColor = task.IsCompleted 
        ? AppColor.GreenColor // Green for completed tasks in CompletedTasksScreen
        : (task.Color == 0
            ? AppColor.PrimaryColor
            : task.Color == 1
                ? AppColor.OrangeColor
                : AppColor.RedColor); // Default colors for HomeScreen
    
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: taskColor, // Set color based on whether the task is completed or not
        borderRadius: BorderRadius.circular(10),       
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.Title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getTitleTextStyle(
                    Color: AppColor.WhiteColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColor.WhiteColor,
                      size: 20,
                    ),
                    Text(
                      task.StartTime,
                      style: getTitleTextStyle(
                        Color: AppColor.WhiteColor,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "  :  ",
                      style: getTitleTextStyle(
                        Color: AppColor.WhiteColor,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      task.EndTime,
                      style: getTitleTextStyle(
                        Color: AppColor.WhiteColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: AppColor.WhiteColor,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              "ToDo",
              style: getSmallTextStyle(
                Color: AppColor.WhiteColor,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
