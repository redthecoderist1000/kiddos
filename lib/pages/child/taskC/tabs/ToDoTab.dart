import 'package:flutter/material.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ToDoTab extends StatefulWidget {
  const ToDoTab({super.key});

  @override
  State<ToDoTab> createState() => _ToDoTabState();
}

class _ToDoTabState extends State<ToDoTab> {
  final supabase = Supabase.instance.client;
  final todochannel = Supabase.instance.client.channel('todo-channel');

  Future<dynamic> loadData() async {
    try {
      final res = await supabase
          .from('vw_alltaskperchild')
          .select()
          .eq('status', 'Assigned');
      // return [];
      return res;
    } catch (e) {
      throw Exception('Error fetching assigned tasks.');
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
    // TODO: implement dispose
    super.dispose();
    todochannel.unsubscribe();
  }

  handleDone(String task_trans_id) async {
    try {
      await supabase
          .from('tbl_task_transaction')
          .update({
            'status': 'Under Review',
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', task_trans_id);
      setSnackBar('Task marked as done!', context, Colors.green);
    } catch (e) {
      setSnackBar(
        'Failed to update task. Try again later.',
        context,
        Colors.red,
      );
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
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return Center(
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEAF2FF), Color(0xFFF8EFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.track_changes,
                        color: Color(0xFF9810FA),
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Ready to Start!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22223B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Your parents haven't added any tasks yet, but they will soon! Get ready for some fun activities.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Color(0xFFFFC700),
                              size: 32,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Tasks will appear here when your parents add them!",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF6B7280),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final tasks = snapshot.data as List;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                                    color: Color(0xFF2972FE),
                                    size: 16,
                                  ),
                                  Text(
                                    '${task['points']} pts',
                                    style: TextStyle(
                                      color: Color(0xFF2972FE),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // action buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              padding: EdgeInsets.all(15),
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Colors.green,
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.check_rounded, size: 20),
                                  Text('Done'),
                                ],
                              ),
                              onPressed: () {
                                handleDone(task['task_trans_id']);
                              },
                            ),
                          ],
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
