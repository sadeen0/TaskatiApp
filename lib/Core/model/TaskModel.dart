import 'package:flutter/material.dart';

class TaskModel {
  String Id;
  String Title;
  String Note;
  String Date;
  String StartTime;
  String EndTime;
  int Color;
  bool IsCompleted;

TaskModel({
  required this.Id,
  required this.Title,
  required this.Note,
  required this.Date,
  required this.StartTime,
  required this.EndTime,
  required this.Color,
  required this.IsCompleted
});
}