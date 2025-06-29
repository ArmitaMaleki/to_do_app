import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_apk/constants/constant_colors.dart';
import 'package:note_apk/data/task.dart';
import 'package:note_apk/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:note_apk/widgets/task_type_item.dart';

class EditScreen extends StatefulWidget {
  EditScreen({
    super.key,
    required this.task,
  });
  Task task;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  FocusNode firstFocus = FocusNode();
  FocusNode secondFocus = FocusNode();

  var box = Hive.box<Task>('taskBox');

  TextEditingController? controllertitle;
  TextEditingController? controllersubtitle;
  DateTime? _time;
  int _selectedTaskTypeItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllertitle = TextEditingController(text: widget.task.title);
    controllersubtitle = TextEditingController(text: widget.task.subTitle);
    firstFocus.addListener(() {
      setState(() {});
    });
    secondFocus.addListener(() {
      setState(() {});
    });
    var index = getTaskTypeList().indexWhere(
      (element) {
        return element.taskTypeEnume == widget.task.taskType.taskTypeEnume;
      },
    );
    _selectedTaskTypeItem = index;
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
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: grey,
                ),
                onPressed: () {
                  String tasktitle = controllertitle!.text;
                  String tasksubtitle = controllersubtitle!.text;
                  EditTask(tasktitle, tasksubtitle);
                  Navigator.of(context).pop();
                },
                child: Text('ویرایش کردن تسک'),
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

  void EditTask(String tasktitle, String tasksubtitle) {
    widget.task.title = tasktitle;
    widget.task.subTitle = tasksubtitle;
    widget.task.time = _time ?? widget.task.time;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItem];
    widget.task.save();
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
