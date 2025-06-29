import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_apk/screens/add_task_screen.dart';
import 'package:note_apk/constants/constant_colors.dart';
import 'package:note_apk/data/task.dart';
import 'package:note_apk/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = TextEditingController();
  String inputText = '';

  var taskBox = Hive.box<Task>('taskBox');
  bool isfabvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backcolor,
     body: Center(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: (context, value, child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notif) {
                setState(() {
                  if (notif.direction == ScrollDirection.forward) {
                    isfabvisible = true;
                  }
                  if (notif.direction == ScrollDirection.reverse) {
                    isfabvisible = false;
                  }
                });

                return true;
              },
              child: ListView.builder(
                itemCount: taskBox.values.length,
                itemBuilder: ((context, index) {
                  var task = taskBox.values.toList()[index];
                  print(task.taskType.title);
                  return getListItems(task);
                }),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: isfabvisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          autofocus: true,
          // mini: true,
          tooltip: 'add task',
          shape: CircleBorder(),
          backgroundColor: green,
          child: Image.asset('images/icon_add.png'),
        ),
      ),
    );
  }
}

Widget getListItems(Task task) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      task.delete();
    },
    child: TaskWidget(task: task),
  );
}
