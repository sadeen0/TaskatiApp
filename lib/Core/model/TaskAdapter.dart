import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/Core/model/TaskModel.dart';

class TaskAdapter extends TypeAdapter<TaskModel> {
  @override
  TaskModel read(BinaryReader reader) {
    // TODO: implement read
    return TaskModel(
      Id: reader.readString(), 
      Title: reader.readString(),
      Note: reader.readString(), 
      Date: reader.readString(),
      StartTime: reader.readString(),
      EndTime: reader.readString(), 
      Color: reader.readInt(),
      IsCompleted: reader.readBool()
      );
  }

  @override
  // TODO: implement typeId
  // 0 - 233
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    // TODO: implement write
    writer.writeString(obj.Id);
    writer.writeString(obj.Title);
    writer.writeString(obj.Note);
    writer.writeString(obj.Date);
    writer.writeString(obj.StartTime);
    writer.writeString(obj.EndTime);
    writer.writeInt(obj.Color);
    writer.writeBool(obj.IsCompleted);
  }
}