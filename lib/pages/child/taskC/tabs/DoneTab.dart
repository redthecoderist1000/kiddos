import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoneTab extends StatefulWidget {
  const DoneTab({super.key});

  @override
  State<DoneTab> createState() => _DoneTabState();
}

class _DoneTabState extends State<DoneTab> {
  final supabase = Supabase.instance.client;
  final todochannel = Supabase.instance.client.channel('done-channel');

  Future<dynamic> loadData() async {
    try {
      final res = await supabase
          .from('vw_alltaskperchild')
          .select()
          .eq('status', 'Completed');
      // return [];
      return res;
    } catch (e) {
      throw Exception('Error fetching completed tasks.');
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
    super.initState();

    todochannel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_task_transaction',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'child_id',
            value: supabase.auth.currentUser!.id,
          ),
          callback: (payload) {
            setState(() {});
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    todochannel.unsubscribe();
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
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return Center(child: Text('No completed tasks found.'));
            } else {
              final tasks = snapshot.data as List;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(15),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // child info
                        Text(getTimeFromTimestamp(task['updated_at'])),
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
                              task['description'] == null
                                  ? const SizedBox()
                                  : Text(
                                      task['description'],
                                      style: TextStyle(color: Colors.black54),
                                    ),
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.stars,
                                    color: Color(0xFF1BAA4A),
                                    size: 16,
                                  ),
                                  Text(
                                    '+ ${task['points']} pts',
                                    style: TextStyle(
                                      color: Color(0xFF1BAA4A),
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
            }
          },
        ),
      ),
    );
  }
}
