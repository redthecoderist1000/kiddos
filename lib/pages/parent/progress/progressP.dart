import 'package:flutter/material.dart';

class ProgressP extends StatefulWidget {
  const ProgressP({super.key});

  @override
  State<ProgressP> createState() => _ProgressPState();
}

class _ProgressPState extends State<ProgressP> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // no need for scaffold

          // start coding here...
          Text('Progress Page (parent)'),
        ],
      ),
    );
  }
}
