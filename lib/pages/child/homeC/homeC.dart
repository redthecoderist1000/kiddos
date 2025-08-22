import 'package:flutter/material.dart';
import '../../../db/task_database_helper.dart';
import '../../../models/task.dart';
import 'home_page/home_stats.dart';
import 'home_page/home_task_card.dart';
import 'home_page/home_points_card.dart';

class HomeC extends StatefulWidget {
  const HomeC({super.key});

  @override
  State<HomeC> createState() => _HomeCState();
}

class _HomeCState extends State<HomeC> {
  late Future<List<Task>> _tasks;
  List<bool> doneStates = [];

  @override
  void initState() {
    super.initState();
    _tasks = TaskDatabaseHelper().getTasks();
  }

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
        return Colors.grey;
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
        return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Column(
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
              const Text(
                "Here's what's on your schedule today.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: const HomeStats(),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                if (doneStates.length != tasks.length) {
                  doneStates = List<bool>.filled(tasks.length, false);
                }
                return Column(
                  children: List.generate(
                    tasks.take(3).length, (index) {
                      final task = tasks[index];
                      return Column(
                        children: [
                          HomeTaskCard(
                            color: _getCardColor(task.category),
                          emoji: _getCardEmoji(task.category),
                          category: task.category,
                          points: task.points,
                          title: task.title,
                          done: doneStates[index],
                          onCheck: () {
                            setState(() {
                              doneStates[index] = !doneStates[index];
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                );
              },
            ),
          ),

          // Points Card (example, you may want to calculate these)
          HomePointsCard(points: 30, completed: doneStates.where((d) => d).length, total: doneStates.length),
        ],
      ),
    );
  }
}