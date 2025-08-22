import 'package:flutter/material.dart';
import '../../../db/task_database_helper.dart';
import '../../../models/task.dart';
import 'home_page/home_stats.dart';
import 'home_page/home_task_card.dart';
import 'home_page/home_points_card.dart';
import '../taskC/taskC.dart'; 

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
      child: FutureBuilder<List<Task>>(
        future: _tasks,
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];

          // Calculate stats
          final int tasksDone = tasks.where((t) => t.isDone).length;
          final int pointsEarned = tasks.fold(0, (sum, t) => sum + (t.isDone ? t.points : 0));

          return Column(
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
                  Text(
                    tasks.isEmpty
                        ? "Welcome to your task adventure! No tasks yet, but that's okay!"
                        : "Here's what's on your schedule today.",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: HomeStats(
                  tasksDone: tasks.isEmpty ? 0 : tasksDone,
                  pointsEarned: tasks.isEmpty ? 0 : pointsEarned,
                ),
              ),
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.hasError
                        ? Center(child: Text('Error: ${snapshot.error}'))
                        : tasks.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      gradient: LinearGradient(
                                        colors: [Color(0xFFFFF7E6), Color(0xFFFDEBFF)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(Icons.star, color: Color(0xFFFFD700), size: 48),
                                        SizedBox(height: 12),
                                        Text(
                                          "Ready for Adventure!",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9810FA),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "No tasks assigned yet, but don't worry! Your parents will add some fun tasks for you to complete soon.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                        SizedBox(height: 24),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(Icons.track_changes, color: Color(0xFFFB5FB3), size: 32),
                                              SizedBox(height: 8),
                                              Text(
                                                "Coming Soon!",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFB5FB3),
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Tasks will appear here when your parents add them. Get ready to earn points and have fun!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Your Tasks Today",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF9810FA),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TaskC(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "See All",
                                          style: TextStyle(
                                            color: Color(0xFF9810FA),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  ...List.generate(
                                    tasks.take(3).length, (index) {
                                      final task = tasks[index];
                                      if (doneStates.length != tasks.length) {
                                        doneStates = List<bool>.filled(tasks.length, false);
                                      }
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
                                    },
                                  ),
                                ],
                              ),
              ),

              // Points Card
              HomePointsCard(
                points: tasks.isEmpty ? 0 : pointsEarned,
                completed: tasks.isEmpty ? 0 : tasksDone,
                total: tasks.isEmpty ? 0 : tasks.length,
              ),
            ],
          );
        },
      ),
    );
  }
}