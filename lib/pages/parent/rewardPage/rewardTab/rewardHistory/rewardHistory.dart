import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'rewardHistoryTile.dart';

class RewardHistory extends StatefulWidget {
  const RewardHistory({Key? key}) : super(key: key);

  @override
  State<RewardHistory> createState() => _RewardHistoryState();
}

class _RewardHistoryState extends State<RewardHistory> {
  final supabase = Supabase.instance.client;
  final requestedChannel = Supabase.instance.client.channel(
    'history-rewards-channel',
  );

  Future<dynamic> loadData() async {
    try {
      final res = await supabase
          .from('vw_rewardparent')
          .select()
          .neq('status', 'Requested');
      return res;
    } catch (e) {
      throw Exception('Failed to load pending rewards.');
    }
  }

  getTimeFromTimestamp(String timestamp) {
    DateTime activityTime = DateTime.parse(timestamp).toLocal();
    Duration difference = DateTime.now().difference(activityTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestedChannel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_reward_transaction',
          callback: (payload) {
            setState(() {});
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    supabase.removeChannel(requestedChannel);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final rewards = snapshot.data;
          return ListView.builder(
            itemCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return RewardHistoryTile(
                childName: reward['user_name'] as String,
                rewardTitle: reward['item_name'] as String,
                description: reward['description'] ?? '',
                points: reward['required_points'] as int,
                redeemedDate: getTimeFromTimestamp(reward['updated_at']),
                category: reward['category'] as String,
                isApproved: reward['status'] == 'Accepted' ? true : false,
              );
            },
          );
        }
      },
    );
  }
}

// RewardHistoryTile(
//   childName: reward['childName'] as String,
//   rewardTitle: reward['rewardTitle'] as String,
//   description: reward['description'] as String,
//   points: reward['points'] as int,
//   redeemedDate: reward['redeemedDate'] as String,
//   category: reward['category'] as String,
//   isApproved: reward['isApproved'] as bool? ?? true,
//   ),
