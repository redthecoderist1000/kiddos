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
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'My Task',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9810FA),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('📝', style: TextStyle(fontSize: 28)),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                "Let's get things done and earn points!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
