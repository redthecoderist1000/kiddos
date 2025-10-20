import 'package:flutter/material.dart';
import 'pendingRewardTile.dart';

class PendingRewardPage extends StatelessWidget {
  const PendingRewardPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pendingRewards = const [
    {
      'childName': 'Emma',
      'rewardTitle': 'Ice Cream Treat',
      'description': 'Choose your favorite flavor',
      'points': 75,
      'requestedDate': '2 hours ago',
      'category': 'Treats',
    },
    {
      'childName': 'Max',
      'rewardTitle': 'Extra Playtime',
      'description': '30 minutes of extra playtime',
      'points': 50,
      'requestedDate': '3 hours ago',
      'category': 'Privileges',
    },
    {
      'childName': 'Lily',
      'rewardTitle': 'Movie Night',
      'description': 'Pick any movie for family night',
      'points': 100,
      'requestedDate': '1 hour ago',
      'category': 'Activities',
    },
    {
      'childName': 'Ben',
      'rewardTitle': 'New Toy',
      'description': 'Choose from the toy store',
      'points': 120,
      'requestedDate': '4 hours ago',
      'category': 'Toys',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pendingRewards.isEmpty)
            const Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Icon(Icons.pending_actions, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No pending rewards.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          else
            ...pendingRewards
                .map(
                  (reward) => PendingRewardTile(
                    childName: reward['childName'] as String,
                    rewardTitle: reward['rewardTitle'] as String,
                    description: reward['description'] as String,
                    points: reward['points'] as int,
                    requestedDate: reward['requestedDate'] as String,
                    category: reward['category'] as String,
                    onApprove: () {
                      // Handle approve
                      print('Approved: ${reward['rewardTitle']}');
                    },
                    onReject: () {
                      // Handle reject
                      print('Rejected: ${reward['rewardTitle']}');
                    },
                  ),
                )
                .toList(),
        ],
      ),
    );
  }
}
