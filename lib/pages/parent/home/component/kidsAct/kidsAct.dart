import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'kidsActTile.dart';

class KidsAct extends StatefulWidget {
  const KidsAct({Key? key}) : super(key: key);

  @override
  State<KidsAct> createState() => _KidsActState();
}

class _KidsActState extends State<KidsAct> {
  final supabase = Supabase.instance.client;
  final channel = Supabase.instance.client.channel('kids-activity-channel');
  Future<dynamic> fetchKidsActivity() async {
    try {
      final res = await supabase.from('vw_kidsact').select('*');
      return res;
    } catch (e) {
      throw Exception('Failed to load kids activity');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel
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

    supabase.removeChannel(channel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(20.0),
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
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: Colors.pink.shade300,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Kids Activity',
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
            future: fetchKidsActivity(),
            builder: (context, snapshot) {
              // Loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Error state
              if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }

              // Data loaded state
              final kidsData = snapshot.data as List<dynamic>;

              // if 0 kids
              if (kidsData.isEmpty) {
                return const Center(
                  child: Text(
                    'No kids activity found.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: kidsData.length,
                itemBuilder: (context, index) {
                  final kid = kidsData[index];
                  return KidsActTile(
                    name: kid['user_name'],
                    avatarColor:
                        Colors.primaries[index % Colors.primaries.length],
                    avatarText: kid['user_name'][0],
                    points: kid['points_earned'] ?? 0,
                    completedTasks: kid['completed_tasks'],
                    totalTasks: kid['total_tasks'],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
