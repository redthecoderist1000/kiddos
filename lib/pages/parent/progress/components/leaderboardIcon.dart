import 'package:flutter/material.dart';

class LeaderBoardIcon extends StatelessWidget {
  final bool isTop1;
  final String name;
  final int score;

  const LeaderBoardIcon({
    super.key,
    required this.isTop1,
    required this.name,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: isTop1 ? 60 : 40,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.face_5_rounded, size: isTop1 ? 100 : 60),
            ),
            Text(
              score.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(name),
          ],
        ),
        isTop1
            ? Positioned(
                right: 0,
                child: Icon(Icons.auto_awesome, size: 40, color: Colors.amber),
              )
            : SizedBox(),
      ],
    );
  }
}
