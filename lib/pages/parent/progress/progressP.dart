import 'package:flutter/material.dart';

class ProgressP extends StatefulWidget {
  const ProgressP({super.key});

  @override
  State<ProgressP> createState() => _ProgressPState();
}

class _ProgressPState extends State<ProgressP> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Progress Page Parent')],
    );
  }
}
