import 'package:flutter/material.dart';

class RewardC extends StatefulWidget {
  const RewardC({super.key});

  @override
  State<RewardC> createState() => _RewardCState();
}

class _RewardCState extends State<RewardC> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Reawrds Page (child)')],
    );
  }
}
