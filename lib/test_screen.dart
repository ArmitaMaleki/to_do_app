import 'package:flutter/material.dart';
import 'package:note_apk/constants/constant_colors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ValueNotifier mobser = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: mobser,
                builder: (context, value, child) {
                  return Text('$value');
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                foregroundColor: grey,
              ),
              onPressed: () {
                mobser.value = mobser.value + 1;
              },
              child: Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
