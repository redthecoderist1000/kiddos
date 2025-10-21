import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TriBox extends StatefulWidget {
  const TriBox({Key? key}) : super(key: key);

  @override
  State<TriBox> createState() => _TriBoxState();
}

class _TriBoxState extends State<TriBox> {
  final supabase = Supabase.instance.client;
  final channel = Supabase.instance.client.channel('overview');
  Future<dynamic> loadData() async {
    try {
      final res = await supabase.from('vw_poverview').select('*').single();
      return res;
    } catch (e) {
      throw Exception('Failed to load parent overview data');
    }
  }

  @override
  void initState() {
    super.initState();
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_task_transaction',
          callback: (payload) => setState(() {}),
        )
        .subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    supabase.removeChannel(channel);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, asyncSnapshot) {
        // Loading state
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (asyncSnapshot.hasError) {
          // Error state
          return SizedBox();
        }

        // Data loaded state
        final data = asyncSnapshot.data;
        // {completed_task: 1, to_review_task: 0, total_task: 2, all_time_points: 200}

        return Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 0.0,
            bottom: 8.0,
          ),
          child: Row(
            children: [
              // Green box - Completed
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50), // Green
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: Colors.white, size: 28),
                      SizedBox(height: 8),
                      Text(
                        '${data['completed_task']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Completed',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Blue box - Remaining
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3), // Blue
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${data['total_task']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Total Tasks',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Orange box - Points
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800), // Orange
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 28),
                      SizedBox(height: 8),
                      Text(
                        '${data['all_time_points']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Points Earned',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
