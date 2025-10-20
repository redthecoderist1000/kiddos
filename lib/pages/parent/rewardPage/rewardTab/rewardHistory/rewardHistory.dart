import 'package:flutter/material.dart';
import 'rewardHistoryTile.dart';

class RewardHistory extends StatelessWidget {
  const RewardHistory({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> rewardHistory = const [
    {
      'childName': 'Emma',
      'rewardTitle': 'Movie Night',
      'description': 'Pick a movie for family night',
      'points': 100,
      'redeemedDate': '1 day ago',
      'category': 'Activities',
      'isApproved': true,
    },
    {
      'childName': 'Sophie',
      'rewardTitle': 'New Book',
      'description': 'Pick a book from the store',
      'points': 120,
      'redeemedDate': '2 days ago',
      'category': 'Others',
      'isApproved': true,
    },
    {
      'childName': 'Emma',
      'rewardTitle': 'Ice Cream Treat',
      'description': 'Choose your favorite flavor',
      'points': 75,
      'redeemedDate': '3 days ago',
      'category': 'Treats',
      'isApproved': false,
    },
    {
      'childName': 'Max',
      'rewardTitle': 'Extra Playtime',
      'description': '30 minutes of extra playtime',
      'points': 50,
      'redeemedDate': '1 week ago',
      'category': 'Privileges',
      'isApproved': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rewardHistory.isEmpty)
          const Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Icon(Icons.history, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No reward history yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          )
        else
          ...rewardHistory
              .map(
                (reward) => RewardHistoryTile(
                  childName: reward['childName'] as String,
                  rewardTitle: reward['rewardTitle'] as String,
                  description: reward['description'] as String,
                  points: reward['points'] as int,
                  redeemedDate: reward['redeemedDate'] as String,
                  category: reward['category'] as String,
                  isApproved: reward['isApproved'] as bool? ?? true,
                ),
              )
              .toList(),
      ],
    );
  }
}
