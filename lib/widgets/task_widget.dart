import 'package:flutter/material.dart';
import 'package:note_apk/constants/constant_colors.dart';
import 'package:note_apk/screens/edit_screen.dart';
import 'package:note_apk/data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isboxChecked = false;

  @override
  void initState() {
    super.initState();

    isboxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isboxChecked = !isboxChecked;
            widget.task.isDone = isboxChecked;
            widget.task.save();
          });
        },
        child: Container(
          height: 132,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: _getMainContent(),
        ),
      ),
    );
  }

  Row _getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: isboxChecked,
                        onChanged: (ischecked) {},
                        checkColor: Colors.white,
                        activeColor: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                      ),
                    ),

                    // MSHCheckbox(
                    //   size: 30,
                    //   value: isboxChecked,
                    //   colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                    //     checkedColor: green,
                    //   ),
                    //   style: MSHCheckboxStyle.fillScaleCheck,
                    //   onChanged: (selected) {
                    //     setState(() {
                    //       isboxChecked = selected;
                    //     });
                    //   },
                    // ),
                    Spacer(),
                    Column(
                      children: [
                        Text(widget.task.title),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 100,
                          child: Text(
                            widget.task.subTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 10),
                  child: _getTimeandEditBadges(),
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          widget.task.taskType.image,
          height: 150,
          width: 150,
        ),
      ],
    );
  }

  Row _getTimeandEditBadges() {
    return Row(
      children: [
        Container(
          width: 83,
          height: 28,
          decoration: BoxDecoration(
            color: green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${widget.task.time.hour}:${getminunderten(widget.task.time)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Image.asset(
                  'images/icon_time.png',
                  height: 15,
                  width: 15,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EditScreen(task: widget.task);
                },
              ),
            );
          },
          child: Container(
            width: 83,
            height: 28,
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      color: green,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'images/icon_edit.png',
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getminunderten(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
