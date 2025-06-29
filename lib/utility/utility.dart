import 'package:note_apk/data/task_type.dart';
import 'package:note_apk/data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'images/banking.png',
        title: 'کارهای بانکی',
        taskTypeEnume: TaskTypeEnum.working),
    TaskType(
        image: 'images/hard_working.png',
        title: 'کار زیاد',
        taskTypeEnume: TaskTypeEnum.working),
    TaskType(
        image: 'images/meditate.png',
        title: 'مدیتیشن',
        taskTypeEnume: TaskTypeEnum.focus),
    TaskType(
        image: 'images/social_friends.png',
        title: 'قرار دوستانه',
        taskTypeEnume: TaskTypeEnum.date),
    TaskType(
        image: 'images/work_meeting.png',
        title: 'قرار کاری',
        taskTypeEnume: TaskTypeEnum.date),
    TaskType(
        image: 'images/workout.png',
        title: 'ورزش',
        taskTypeEnume: TaskTypeEnum.focus),
  ];
  return list;
}
