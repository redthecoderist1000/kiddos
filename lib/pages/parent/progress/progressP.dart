import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kiddos/pages/parent/progress/components/leaderboards.dart';
import 'package:kiddos/pages/parent/progress/components/progressCard.dart';

class ProgressP extends StatefulWidget {
  const ProgressP({super.key});

  @override
  State<ProgressP> createState() => _ProgressPState();
}

class _ProgressPState extends State<ProgressP> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    List leaderboards = [
      {'name': '@nabong', 'score': 0},
      {'name': '@yoopewpew', 'score': 0},
      {'name': '@momoring', 'score': 0},
      {'name': '@shashahsa', 'score': 0},
      {'name': '@zyozyo', 'score': 0},
      {'name': '@nabong', 'score': 0},
      {'name': '@yoopewpew', 'score': 0},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress',
            style: TextStyle(
              fontSize: isSmall ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B3EFF),
            ),
          ),
          SizedBox(height: isSmall ? 4 : 8),
          Text(
            "Indulge how great your children are doing so far!",
            style: TextStyle(
              fontSize: isSmall ? 13 : 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isSmall ? 16 : 28),

          // Leaderboards
          Leaderboards(),

          // carousel
          CarouselSlider(
            items: List.generate(leaderboards.length, (index) {
              final item = leaderboards[index];

              return ProgressCard(item: item);
            }),
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.85,
              aspectRatio: 2.0,
              enableInfiniteScroll: false,
              height: 600,
            ),
          ),
        ],
      ),
    );
  }
}
