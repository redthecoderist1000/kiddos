import 'package:flutter/material.dart';

class TaskC extends StatefulWidget {
  const TaskC({super.key});

  @override
  State<TaskC> createState() => TtaskCState();
}

class TtaskCState extends State<TaskC> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // no need for scaffold

          // start coding here...
          Text('Tasks Page (child)'),
        ],
      ),
    );
  }
}
