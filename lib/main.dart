import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_apk/screens/home_screen.dart';
import 'package:note_apk/data/task.dart';
import 'package:note_apk/data/task_type.dart';
import 'package:note_apk/data/type_enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<TaskType>('taskTypeBox');
  await Hive.openBox<Task>('taskBox');

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'SM',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
