import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_apk/constants/constant_colors.dart';
import 'package:note_apk/data/task.dart';
import 'package:note_apk/utility/utility.dart';
import 'package:note_apk/widgets/task_type_item.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode firstFocus = FocusNode();
  FocusNode secondFocus = FocusNode();

  var box = Hive.box<Task>('taskBox');

  TextEditingController controllertitle = TextEditingController();
  TextEditingController controllersubtitle = TextEditingController();

  DateTime? _time;

  int _selectedTaskTypeItem = 0;

  @override
  void initState() {
    super.initState();
    firstFocus.addListener(() {
      setState(() {});
    });
    secondFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: controllertitle,
                  focusNode: firstFocus,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      labelText: 'عنوان تسک',
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(color: Color(0xffC5C5C5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(color: green),
                      ),
                      focusColor: green,
                      floatingLabelStyle:
                          TextStyle(color: firstFocus.hasFocus ? green : grey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: controllersubtitle,
                  maxLines: 2,
                  focusNode: secondFocus,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      labelText: 'توضیحات تسک',
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(color: Color(0xffC5C5C5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(color: green),
                      ),
                      focusColor: green,
                      floatingLabelStyle: TextStyle(
                          color: secondFocus.hasFocus ? green : grey)),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: 'زمان خود را انتخاب کنید',
                  titleStyle:
                      TextStyle(color: green, fontWeight: FontWeight.bold),
                  negativeButtonText: 'حذف',
                  positiveButtonText: 'انتخاب',
                  negativeButtonStyle: TextStyle(color: red, fontSize: 15),
                  positiveButtonStyle: TextStyle(color: green, fontSize: 15),
                  onNegativePressed: (context) {},
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                ),
              ),
              _getTaskCondition(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 20,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: grey,
                        minimumSize: Size(135, 50),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('بازگشت'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        foregroundColor: grey,
                        minimumSize: Size(100, 50),
                      ),
                      onPressed: () {
                        String tasktitle = controllertitle.text.trim();
                        String tasksubtitle = controllersubtitle.text;

                        if (tasktitle.isEmpty) {
                          showTopSnackBar(
                            displayDuration: Duration(seconds: 1),
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: ' !لطفا عنوان تسک را بنویسید',
                              textAlign: TextAlign.right,
                            ),
                          );
                          return;
                        }

                        if (_time == null) {
                          showTopSnackBar(
                            displayDuration: Duration(seconds: 1),
                            Overlay.of(context),
                            CustomSnackBar.info(
                              message: ' !لطفا زمان تسک را انتخاب کنید',
                            ),
                          );
                          return;
                        }

                        addTask(tasktitle, tasksubtitle);
                        Navigator.of(context).pop();
                      },
                      child: Text('اضافه کردن تسک'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    firstFocus.dispose();
    secondFocus.dispose();
    super.dispose();
  }

  void addTask(String tasktitle, String tasksubtitle) {
    var task = Task(
        title: tasktitle,
        subTitle: tasksubtitle,
        time: _time!,
        taskType: getTaskTypeList()[_selectedTaskTypeItem]);
    box.add(task);
  }

  Widget _getTaskCondition() {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Container(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: getTaskTypeList().length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedTaskTypeItem = index;
                });
              },
              child: getconditionItems(
                taskType: getTaskTypeList()[index],
                index: index,
                selectedItemList: _selectedTaskTypeItem,
              ),
            );
          },
        ),
      ),
    );
  }
}
