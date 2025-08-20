import 'package:flutter/material.dart';
import '../../../db/home_task_db_helper.dart';
import 'home_page/home_stats.dart';
import 'home_page/home_task_card.dart';
import 'home_page/home_points_card.dart';

class HomeC extends StatefulWidget {
  const HomeC({super.key});

  @override
  State<HomeC> createState() => _HomeCState();
}

class _HomeCState extends State<HomeC> {
  List<HomeTask> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final dbTasks = await HomeTaskDbHelper.instance.getTasks();
    // If database is empty, insert default tasks
    if (dbTasks.isEmpty) {
      await _insertDefaultTasks();
      final newDbTasks = await HomeTaskDbHelper.instance.getTasks();
      setState(() {
        tasks = newDbTasks;
      });
    } else {
      setState(() {
        tasks = dbTasks;
      });
    }
  }

  Future<void> _insertDefaultTasks() async {
    final defaultTasks = [
      HomeTask(
        category: 'cleaning',
        points: 30,
        title: 'Tidy up your room',
        done: false,
        iconCode: Icons.cleaning_services.codePoint,
        iconColorValue: Colors.white.value,
        colorValue: const Color(0xFFBF76FF).value,
      ),
      HomeTask(
        category: 'personal',
        points: 15,
        title: 'Brush your teeth',
        done: false,
        iconCode: Icons.medical_services.codePoint,
        iconColorValue: Colors.white.value,
        colorValue: const Color(0xFFFB5FB3).value,
      ),
      HomeTask(
        category: 'learning',
        points: 25,
        title: 'Do your homework',
        done: false,
        iconCode: Icons.menu_book.codePoint,
        iconColorValue: Colors.white.value,
        colorValue: const Color(0xFF4D9FFF).value,
      ),
      HomeTask(
        category: 'helping',
        points: 20,
        title: 'Do the house chores',
        done: false,
        iconCode: Icons.local_dining.codePoint,
        iconColorValue: Colors.white.value,
        colorValue: const Color(0xFF76E5FF).value,
      ),
    ];
    for (var task in defaultTasks) {
      await HomeTaskDbHelper.instance.insertTask(task);
    }
  }

  Future<void> _toggleDone(HomeTask task) async {
    final updatedTask = HomeTask(
      id: task.id,
      category: task.category,
      points: task.points,
      title: task.title,
      done: !task.done,
      iconCode: task.iconCode,
      iconColorValue: task.iconColorValue,
      colorValue: task.colorValue,
    );
    await HomeTaskDbHelper.instance.updateTask(updatedTask);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    int completed = tasks.where((t) => t.done).length;
    int total = tasks.length;
    int points = tasks.where((t) => t.done).fold(0, (sum, t) => sum + t.points);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
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
            child: HomeStats(
              tasksDone: completed,
              pointsEarned: points,
            ),
          ),
          const SizedBox(height: 24),

          // Task Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: tasks.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        const Text(
                          "Yey! No tasks yet!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Enjoy your free time while you wait for your parent to add new tasks. 😊",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: tasks.map((task) {
                      return Column(
                        children: [
                          HomeTaskCard(
                            color: Color(task.colorValue),
                            icon: IconData(task.iconCode, fontFamily: 'MaterialIcons'),
                            iconColor: Color(task.iconColorValue),
                            category: task.category,
                            points: task.points,
                            title: task.title,
                            done: task.done,
                            onCheck: () => _toggleDone(task),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
          ),

          HomePointsCard(points: points, completed: completed, total: total),
        ],
      ),
    );
  }
}