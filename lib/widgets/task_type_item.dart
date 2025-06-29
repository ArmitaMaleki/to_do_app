import 'package:flutter/material.dart';
import 'package:note_apk/constants/constant_colors.dart';
import 'package:note_apk/data/task_type.dart';

class getconditionItems extends StatelessWidget {
 getconditionItems({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemList,
  });
  TaskType taskType;
  int index;
  int selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (selectedItemList == index) ? green : grey,
        border: Border.all(
            width: 3, color: (selectedItemList == index) ? green : grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(taskType.title),
        ],
      ),
    );
  }
}
