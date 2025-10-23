import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RedeemDialog extends StatelessWidget {
  final dynamic reward;
  const RedeemDialog({super.key, required this.reward});

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
    final supabase = Supabase.instance.client;
    final provider = Provider.of<KiddosProvider>(context);

    redeem() async {
      if (provider.userDetails!['current_points'] < reward['required_points']) {
        context.pop();
        setSnackBar('Insufficient points. Git gud kid!', context, Colors.red);
        return;
      }
      try {
        await supabase.from('tbl_reward_transaction').insert({
          'reward_id': reward['id'],
          'status': 'Requested',
        });
        context.pop();
        provider.updateUserDetails({
          'current_points':
              provider.userDetails!['current_points'] -
              reward['required_points'],
        });
        setSnackBar(
          'Your parent has been notified of your reward.',
          context,
          Colors.green,
        );
      } catch (e) {
        setSnackBar(
          'Failed to redeem reward. Try again later.',
          context,
          Colors.red,
        );
      }
    }

    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(10),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: _getCategoryColor(reward['category']).withAlpha(100),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -30,
                  right: -30,
                  child: Icon(
                    _getCategoryIcon(reward['category']),
                    color: _getCategoryColor(reward['category']),
                    size: 150,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward['category'],
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Text(
                  '${reward['item_name']}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Required Points:', style: TextStyle(fontSize: 16)),
                    Text(
                      '${reward['required_points']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Available Points:', style: TextStyle(fontSize: 16)),
                    Text(
                      '${provider.userDetails!['current_points']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.green,
          onPressed: redeem,
          child: const Text('Redeem', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
