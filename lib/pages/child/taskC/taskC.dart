import 'package:flutter/material.dart';
import 'tab_item.dart';
import '../homeC/home_page/home_task_card.dart';
import '../../../models/task.dart';
import '../../../db/task_database_helper.dart';


class TaskC extends StatefulWidget {
  const TaskC({super.key});

  @override
  State<TaskC> createState() => _TtaskCState();
}

class _TtaskCState extends State<TaskC> {
  int selectedTab = 0;
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = TaskDatabaseHelper().getTasks();
  }

  // Add these helper methods:
  Color _getCardColor(String category) {
    switch (category) {
      case 'cleaning':
        return const Color(0xFFBF76FF);
      case 'personal':
        return const Color(0xFFFB5FB3);
      case 'learning':
        return const Color(0xFF4D9FFF);
      case 'helping':
        return const Color(0xFF76E5FF);
      default:
        return Colors.blue;
    }
  }

  String _getCardEmoji(String category) {
    switch (category) {
      case 'cleaning':
        return '🧹';
      case 'personal':
        return '🧴';
      case 'learning':
        return '📚';
      case 'helping':
        return '🤝';
      default:
        return '⭐';
    }
  }

  final List<String> tasks = []; 

  final List<Map<String, dynamic>> tabs = [
    {
      'title': 'Ready',
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
    return Scaffold(
      body: Column(
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
                    const Text(
                      'Hello Lily!',
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
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _tasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final tasks = snapshot.data ?? [];
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet!'));
                }

                List<Task> filteredTasks;
                if (selectedTab == 0) {
                  filteredTasks = tasks.where((t) => !t.isDone).toList();
                } else if (selectedTab == 1) {
                  filteredTasks = tasks.where((t) => !t.isDone).toList();
                } else {
                  filteredTasks = tasks.where((t) => t.isDone).toList();
                }

                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: HomeTaskCard(
                        color: _getCardColor(task.category), // Use category color
                        emoji: _getCardEmoji(task.category), // Use category emoji
                        category: task.category,
                        points: task.points,
                        title: task.title,
                        done: task.isDone,
                        onCheck: () {
                          // Handle check logic if needed
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}