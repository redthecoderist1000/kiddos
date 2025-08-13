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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: leaderboards.length,
            itemBuilder: (context, index) {
              final item = leaderboards[index];

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
            },
          ),
        ),

        //
      ],
    );
  }
}
