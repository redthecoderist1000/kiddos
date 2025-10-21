import 'package:flutter/material.dart';
import 'package:kiddos/pages/parent/progress/components/leaderboardIcon.dart';

class Top3 extends StatelessWidget {
  final List list;

  const Top3({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final first = list[0];
    // final second = ;
    // final third = ;

    return SizedBox(
      width: double.infinity,

      child: Stack(
        children: [
          // second
          list.length < 2
              ? SizedBox()
              : Positioned(
                  bottom: 0,
                  left: screenWidth * 0.15, // 15% from left
                  child: LeaderBoardIcon(
                    isTop1: false,
                    name: list[1]['user_name'],
                    score: list[1]['total_earned'],
                  ),
                ),

          // third
          list.length < 3
              ? SizedBox()
              : Positioned(
                  bottom: 0,
                  right: screenWidth * 0.15, // 15% from right
                  child: LeaderBoardIcon(
                    isTop1: false,
                    name: list[2]['user_name'],
                    score: list[2]['total_earned'],
                  ),
                ),
          Center(
            child: LeaderBoardIcon(
              isTop1: true,
              name: first['user_name'],
              score: first['total_earned'],
            ),
          ),
        ],
      ),
    );
  }
}
