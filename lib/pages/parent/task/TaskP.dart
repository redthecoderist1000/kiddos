import 'package:flutter/material.dart';

class TaskP extends StatefulWidget {
  const TaskP({super.key});

  @override
  State<TaskP> createState() => _TaskPState();
}

class _TaskPState extends State<TaskP> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Parent Page Parent')],
    );
  }
}
