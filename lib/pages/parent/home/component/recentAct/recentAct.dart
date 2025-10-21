import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'recentActTile.dart';

class RecentAct extends StatefulWidget {
  const RecentAct({Key? key}) : super(key: key);

  @override
  State<RecentAct> createState() => _RecentActState();
}

class _RecentActState extends State<RecentAct> {
  final supabase = Supabase.instance.client;
  final rewardChannel = Supabase.instance.client.channel('reward-channel');
  final taskChannel = Supabase.instance.client.channel('task-channel');

  Future<dynamic> loadActivity() async {
    try {
      final res = await supabase
          .from('vw_recact')
          .select()
          .order('updated_at', ascending: false)
          .limit(10);

      return res;
    } catch (e) {
      throw Exception('Failed to load recent activities.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rewardChannel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_reward_transaction',
          callback: (payload) => {setState(() {})},
        )
        .subscribe();

    taskChannel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_task_transaction',
          callback: (payload) => {setState(() {})},
        )
        .subscribe();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    supabase.removeChannel(rewardChannel);
    supabase.removeChannel(taskChannel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.access_time,
                  color: Colors.blue.shade400,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          FutureBuilder(
            future: loadActivity(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return const Center(child: Text('No recent activities found.'));
              }

              final activities = snapshot.data as List;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return RecentActTile(data: activity);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
