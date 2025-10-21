import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  final supabase = Supabase.instance.client;
  final taskChannel = Supabase.instance.client.channel(
    'completed_tasks_channel',
  );

  Future<dynamic> fetchReviewTasks() async {
    try {
      final res = await supabase
          .from('vw_taskmanager')
          .select()
          .eq('status', 'Completed');
      return res;
    } catch (e) {
      throw Exception('Error fetching completed tasks');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskChannel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_task_transaction',
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
    supabase.removeChannel(taskChannel);
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: FutureBuilder(
          future: fetchReviewTasks(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Center(child: CircularProgressIndicator())],
                ),
              );
            } else if (asyncSnapshot.hasError) {
              return SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: Text('${asyncSnapshot.error}'))],
                ),
              );
            } else if (!asyncSnapshot.hasData ||
                (asyncSnapshot.data as List).isEmpty) {
              return SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Center(child: Text('No tasks to review.'))],
                ),
              );
            }

            final tasks = asyncSnapshot.data as List;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(50),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),

                  child: Column(
                    spacing: 10,
                    children: [
                      // child info
                      Row(
                        spacing: 10,
                        children: [
                          CircleAvatar(child: Text(task['user_name'][0])),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task['user_name']),
                              Text(getTimeFromTimestamp(task['updated_at'])),
                            ],
                          ),
                        ],
                      ),

                      // task details
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task['task_name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            task['task_description'] == null
                                ? const SizedBox()
                                : Text(
                                    task['task_description'],
                                    style: TextStyle(color: Colors.black54),
                                  ),
                            Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.stars,
                                  color: Color(0xFF16C98D),
                                  size: 16,
                                ),
                                Text(
                                  '${task['points']} pts',
                                  style: TextStyle(
                                    color: Color(0xFF16C98D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
