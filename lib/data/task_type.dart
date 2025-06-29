import 'package:hive/hive.dart';
import 'package:note_apk/data/type_enum.dart';
part 'task_type.g.dart';

@HiveType(typeId: 6)
class TaskType {
  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  TaskTypeEnum  taskTypeEnume;

  TaskType(
      {required this.image, required this.title, required this.taskTypeEnume});
}
