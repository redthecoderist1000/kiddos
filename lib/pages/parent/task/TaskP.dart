import 'package:flutter/material.dart';

class TaskP extends StatelessWidget {
  const TaskP({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Task Manager",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7A1FA0),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Feel the nostalgia with the tasks you’ve accomplished so far!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              _buildTaskSection(
                title: "In Progress",
                dotColor: Colors.purple,
                gradientColors: const [Color(0xFFA991D2), Color(0xFFF7C0E9)],
                tasks: [
                  TaskItem(
                    title: "Do Homework",
                    category: "Educational",
                    categoryColor: Colors.purple,
                  ),
                  TaskItem(
                    title: "Play Games",
                    category: "Leisure",
                    categoryColor: Colors.purple,
                  ),
                  TaskItem(
                    title: "Play Soccer",
                    category: "Recreational",
                    categoryColor: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTaskSection(
                title: "Done",
                dotColor: Colors.green,
                gradientColors: const [Color(0xFFA8CD89), Color(0xFFEBF3E5)],
                tasks: [
                  TaskItem(
                    title: "Do Homework",
                    category: "Educational",
                    categoryColor: Colors.green,
                  ),
                  TaskItem(
                    title: "Play Games",
                    category: "Leisure",
                    categoryColor: Colors.green,
                  ),
                  TaskItem(
                    title: "Play Soccer",
                    category: "Recreational",
                    categoryColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildTaskSection(
                title: "Not Yet Done",
                dotColor: Colors.red,
                gradientColors: const [Color(0xFFEC6F9E), Color(0xFFEC8B6A)],
                tasks: [
                  TaskItem(
                    title: "Read a Book",
                    category: "Educational",
                    categoryColor: Colors.red,
                  ),
                  TaskItem(
                    title: "Clean Room",
                    category: "Chores",
                    categoryColor: Colors.red,
                  ),
                  TaskItem(
                    title: "Practice Guitar",
                    category: "Recreational",
                    categoryColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskSection({
    required String title,
    required Color dotColor,
    required List<Color> gradientColors,
    required List<TaskItem> tasks,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(children: tasks),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final String category;
  final Color categoryColor;

  const TaskItem({
    super.key,
    required this.title,
    required this.category,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                "Well Done!",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: categoryColor,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    color: categoryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}