import 'package:flutter/material.dart';
import 'package:kiddos/pages/child/rewardC/components/redeemDialog.dart';

class RewardCard extends StatelessWidget {
  final dynamic reward;
  const RewardCard({super.key, required this.reward});

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Privileges':
        return const Color(0xFF2196F3); // Blue
      case 'Toys':
        return const Color(0xFFF44336); // Red
      case 'Treats':
        return const Color(0xFF4CAF50); // Green
      case 'Activities':
        return const Color(0xFFFF9800); // Orange
      case 'Others':
        return const Color(0xFF9C27B0); // Purple
      default:
        return const Color(0xFF607D8B); // Blue Grey
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Privileges':
        return Icons.star;
      case 'Toys':
        return Icons.toys;
      case 'Treats':
        return Icons.icecream;
      case 'Activities':
        return Icons.movie;
      case 'Others':
        return Icons.more_horiz;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    handleRedeem() {
      showDialog(
        context: context,
        builder: (context) {
          return RedeemDialog(reward: reward);
        },
      );
    }

    return GestureDetector(
      onTap: handleRedeem,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: 100,
              decoration: BoxDecoration(
                color: _getCategoryColor(reward['category']).withAlpha(100),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: -20,
                    right: -20,
                    child: Icon(
                      _getCategoryIcon(reward['category']),
                      color: _getCategoryColor(reward['category']),
                      size: 100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reward['category'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${reward['required_points']} points'),
              ],
            ),
            Text(
              reward['item_name'],
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
