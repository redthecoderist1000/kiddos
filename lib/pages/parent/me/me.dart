import 'package:flutter/material.dart';

class MeP extends StatefulWidget {
  const MeP({super.key});

  @override
  State<MeP> createState() => _MePState();
}

class _MePState extends State<MeP> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Me Page Parent')],
    );
  }
}
