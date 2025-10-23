import 'package:flutter/material.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:kiddos/pages/child/taskC/tabs/ApprovalTab.dart';
import 'package:kiddos/pages/child/taskC/tabs/DoneTab.dart';
import 'package:kiddos/pages/child/taskC/tabs/ToDoTab.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tab_item.dart';

class TaskC extends StatefulWidget {
  const TaskC({super.key});

  @override
  State<TaskC> createState() => _TtaskCState();
}

class _TtaskCState extends State<TaskC> {
  final supabase = Supabase.instance.client;
  int selectedTab = 0;

  final List<String> tasks = [];

  final List<Map<String, dynamic>> tabs = [
    {
      'title': 'To Do',
      'count': 7,
      'icon': Icons.radio_button_checked,
      'color': Color(0xFF2563EB),
      'badgeColor': Color(0xFF2563EB),
    },
    {
      'title': 'Approval',
      'count': 4,
      'icon': Icons.access_time,
      'color': Color(0xFFB97A1A),
      'badgeColor': Color(0xFFB97A1A),
    },
    {
      'title': 'Done',
      'count': 2,
      'icon': Icons.emoji_events,
      'color': Color(0xFF1BAA4A),
      'badgeColor': Color(0xFF1BAA4A),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KiddosProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hello ${provider.userDetails!['user_name']}!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9810FA),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('👋', style: TextStyle(fontSize: 28)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                tasks.isEmpty
                    ? "No tasks yet, but your adventure starts here!"
                    : "Here's what's on your schedule today.",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        // Custom Tab Bar using TabItem
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 48,
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
            child: Row(
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                return TabItem(
                  title: tab['title'],
                  count: tab['count'],
                  icon: tab['icon'],
                  color: tab['color'],
                  badgeColor: tab['badgeColor'],
                  isSelected: selectedTab == index,
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                );
              }),
            ),
          ),
        ),

        // Tab Content
        if (selectedTab == 0) Expanded(child: ToDoTab()),
        if (selectedTab == 1) ApprovalTab(),
        if (selectedTab == 2) DoneTab(),

        // Expanded(
        //   child: FutureBuilder<List<Task>>(
        //     future: _tasks,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //       if (snapshot.hasError) {
        //         return Center(child: Text('Error: ${snapshot.error}'));
        //       }
        //       final tasks = snapshot.data ?? [];
        //       if (tasks.isEmpty) {
        //         if (selectedTab == 0) {
        //           // Ready tab empty state
        //           return Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 24),
        //             child: Center(
        //               child: Container(
        //                 width: 320,
        //                 padding: const EdgeInsets.all(24),
        //                 decoration: BoxDecoration(
        //                   gradient: const LinearGradient(
        //                     colors: [Color(0xFFEAF2FF), Color(0xFFF8EFFF)],
        //                     begin: Alignment.topLeft,
        //                     end: Alignment.bottomRight,
        //                   ),
        //                   borderRadius: BorderRadius.circular(24),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.black12,
        //                       blurRadius: 12,
        //                       offset: Offset(0, 4),
        //                     ),
        //                   ],
        //                 ),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     const Icon(
        //                       Icons.track_changes,
        //                       color: Color(0xFF9810FA),
        //                       size: 48,
        //                     ),
        //                     const SizedBox(height: 12),
        //                     const Text(
        //                       'Ready to Start!',
        //                       style: TextStyle(
        //                         fontSize: 22,
        //                         fontWeight: FontWeight.bold,
        //                         color: Color(0xFF22223B),
        //                       ),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                     const SizedBox(height: 10),
        //                     const Text(
        //                       "Your parents haven't added any tasks yet, but they will soon! Get ready for some fun activities.",
        //                       style: TextStyle(
        //                         fontSize: 15,
        //                         color: Color(0xFF6B7280),
        //                       ),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                     const SizedBox(height: 18),
        //                     Container(
        //                       padding: const EdgeInsets.symmetric(
        //                         vertical: 14,
        //                         horizontal: 18,
        //                       ),
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(16),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Colors.black12,
        //                             blurRadius: 8,
        //                             offset: Offset(0, 2),
        //                           ),
        //                         ],
        //                       ),
        //                       child: Column(
        //                         children: const [
        //                           Icon(
        //                             Icons.star,
        //                             color: Color(0xFFFFC700),
        //                             size: 32,
        //                           ),
        //                           SizedBox(height: 8),
        //                           Text(
        //                             "Tasks will appear here when your parents add them!",
        //                             style: TextStyle(
        //                               fontSize: 15,
        //                               color: Color(0xFF6B7280),
        //                             ),
        //                             textAlign: TextAlign.center,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //         } else if (selectedTab == 1) {
        //           // Approval tab empty state
        //           return Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 24),
        //             child: Center(
        //               child: Container(
        //                 width: 320,
        //                 padding: const EdgeInsets.all(24),
        //                 decoration: BoxDecoration(
        //                   gradient: const LinearGradient(
        //                     colors: [Color(0xFFFFF6E7), Color(0xFFFFF0E7)],
        //                     begin: Alignment.topLeft,
        //                     end: Alignment.bottomRight,
        //                   ),
        //                   borderRadius: BorderRadius.circular(24),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.black12,
        //                       blurRadius: 12,
        //                       offset: Offset(0, 4),
        //                     ),
        //                   ],
        //                 ),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     const Icon(
        //                       Icons.access_alarm,
        //                       color: Color(0xFFB97A1A),
        //                       size: 48,
        //                     ),
        //                     const SizedBox(height: 12),
        //                     const Text(
        //                       'Nothing waiting!',
        //                       style: TextStyle(
        //                         fontSize: 22,
        //                         fontWeight: FontWeight.bold,
        //                         color: Color(0xFF22223B),
        //                       ),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                     const SizedBox(height: 10),
        //                     const Text(
        //                       "Complete some tasks and they'll show up here waiting for approval from your parents!",
        //                       style: TextStyle(
        //                         fontSize: 15,
        //                         color: Color(0xFF6B7280),
        //                       ),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //         } else {
        //           // Done tab empty state
        //           return Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 24),
        //             child: Center(
        //               child: Container(
        //                 width: 320,
        //                 padding: const EdgeInsets.all(24),
        //                 decoration: BoxDecoration(
        //                   gradient: const LinearGradient(
        //                     colors: [Color(0xFFE7FFF6), Color(0xFFE7F3FF)],
        //                     begin: Alignment.topLeft,
        //                     end: Alignment.bottomRight,
        //                   ),
        //                   borderRadius: BorderRadius.circular(24),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.black12,
        //                       blurRadius: 12,
        //                       offset: Offset(0, 4),
        //                     ),
        //                   ],
        //                 ),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     const Icon(
        //                       Icons.emoji_events,
        //                       color: Color(0xFF1BAA4A),
        //                       size: 48,
        //                     ),
        //                     const SizedBox(height: 12),
        //                     const Text(
        //                       'Ready for Success!',
        //                       style: TextStyle(
        //                         fontSize: 22,
        //                         fontWeight: FontWeight.bold,
        //                         color: Color(0xFF22223B),
        //                       ),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                     const SizedBox(height: 10),
        //                     const Text(
        //                       "Your completed tasks and earned points will show up here. Start completing tasks to see your achievements!",
        //                       style: TextStyle(
        //                         fontSize: 15,
        //                         color: Color(0xFF6B7280),
        //                       ),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                     const SizedBox(height: 18),
        //                     Container(
        //                       padding: const EdgeInsets.symmetric(
        //                         vertical: 14,
        //                         horizontal: 18,
        //                       ),
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(16),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Colors.black12,
        //                             blurRadius: 8,
        //                             offset: Offset(0, 2),
        //                           ),
        //                         ],
        //                       ),
        //                       child: Column(
        //                         children: const [
        //                           Icon(
        //                             Icons.celebration,
        //                             color: Color(0xFF9810FA),
        //                             size: 32,
        //                           ),
        //                           SizedBox(height: 8),
        //                           Text(
        //                             "Every completed task is a step toward earning points and rewards!",
        //                             style: TextStyle(
        //                               fontSize: 15,
        //                               color: Color(0xFF6B7280),
        //                             ),
        //                             textAlign: TextAlign.center,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //         }
        //       }

        //       List<Task> filteredTasks;
        //       if (selectedTab == 0) {
        //         filteredTasks = tasks.where((t) => !t.isDone).toList();
        //       } else if (selectedTab == 1) {
        //         filteredTasks = tasks.where((t) => !t.isDone).toList();
        //       } else {
        //         filteredTasks = tasks.where((t) => t.isDone).toList();
        //       }

        //       return ListView.builder(
        //         itemCount: filteredTasks.length,
        //         itemBuilder: (context, index) {
        //           final task = filteredTasks[index];
        //           return Padding(
        //             padding: const EdgeInsets.symmetric(
        //               vertical: 8.0,
        //               horizontal: 16.0,
        //             ),
        //             child: HomeTaskCard(
        //               color: _getCardColor(task.category), // Use category color
        //               emoji: _getCardEmoji(task.category), // Use category emoji
        //               category: task.category,
        //               points: task.points,
        //               title: task.title,
        //               done: task.isDone,
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
