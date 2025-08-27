import 'package:flutter/material.dart';

class ProgressTile extends StatelessWidget {
  final dynamic item;

  const ProgressTile({super.key, this.item});

  get index => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 30,
      children: [
        Text('${index + 1}'),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.face_5_rounded, size: 30),
                ),
                Text(item['name']),
                Text(item['score'].toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
