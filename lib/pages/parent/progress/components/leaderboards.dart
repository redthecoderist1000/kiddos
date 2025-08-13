import 'package:flutter/material.dart';
import 'package:kiddos/pages/parent/progress/components/top3.dart';

class Leaderboards extends StatelessWidget {
  const Leaderboards({super.key});

  @override
  Widget build(BuildContext context) {
    List leaderboards = [
      {'name': '@nabong', 'score': 0},
      {'name': '@yoopewpew', 'score': 0},
      {'name': '@momoring', 'score': 0},
      {'name': '@shashahsa', 'score': 0},
      {'name': '@zyozyo', 'score': 0},
    ];

    return Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        // top 3
        Top3(list: leaderboards),

        // etc..

        //
      ],
    );
  }
}
