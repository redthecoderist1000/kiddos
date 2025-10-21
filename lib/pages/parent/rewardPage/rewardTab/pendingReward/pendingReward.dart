import 'package:flutter/material.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pendingRewardTile.dart';

class PendingRewardPage extends StatefulWidget {
  const PendingRewardPage({Key? key}) : super(key: key);

  @override
  State<PendingRewardPage> createState() => _PendingRewardPageState();
}

class _PendingRewardPageState extends State<PendingRewardPage> {
  final supabase = Supabase.instance.client;
  final requestedChannel = Supabase.instance.client.channel(
    'requested-rewards-channel',
  );

  Future<dynamic> loadData() async {
    try {
      final res = await supabase
          .from('vw_rewardparent')
          .select()
          .eq('status', 'Requested');
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

  denyRequest(reward_tran_id) async {
    try {
      await supabase
          .from('tbl_reward_transaction')
          .update({
            'status': 'Rejected',
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id', reward_tran_id);

      setSnackBar('Request updated successfully', context, Colors.green);
    } catch (e) {
      setSnackBar('Failed to update request', context, Colors.red);
    }
  }

  approveRequest(reward_tran_id) async {
    try {
      await supabase
          .from('tbl_reward_transaction')
          .update({
            'status': 'Accepted',
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id', reward_tran_id);

      setSnackBar('Request updated successfully', context, Colors.green);
    } catch (e) {
      setSnackBar('Failed to update request', context, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Center(child: CircularProgressIndicator())],
                ),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: Text('Error: ${snapshot.error}'))],
                ),
              );
            } else if (!snapshot.hasData || (snapshot.data).isEmpty) {
              return const Center(child: Text('No pending rewards found.'));
            } else {
              final rewards = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  return PendingRewardTile(
                    childName: reward['user_name'] as String,
                    rewardTitle: reward['item_name'] as String,
                    description: reward['description'] ?? '',
                    points: reward['required_points'] as int,
                    requestedDate: getTimeFromTimestamp(reward['updated_at']),
                    category: reward['category'] as String,
                    onApprove: () => approveRequest(reward['reward_tran_id']),
                    onReject: () => denyRequest(reward['reward_tran_id']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
