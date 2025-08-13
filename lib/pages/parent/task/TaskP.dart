import 'package:flutter/material.dart';

class TaskP extends StatefulWidget {
  const TaskP({super.key});

  @override
  State<TaskP> createState() => _TaskPState();
}

class _TaskPState extends State<TaskP> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // no need for scaffold

          // start coding here...
          Text('Task Page (parent)'),
        ],
      ),
    );
  }
}
