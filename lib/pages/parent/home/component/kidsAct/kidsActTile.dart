import 'package:flutter/material.dart';

class KidsActTile extends StatelessWidget {
  final String name;
  final String imagePath;
  final Color? avatarColor;
  final String? avatarText;
  final int points;
  final int completedTasks;
  final int totalTasks;

  const KidsActTile({
    Key? key,
    required this.name,
    this.imagePath = '',
    this.avatarColor,
    this.avatarText,
    required this.points,
    required this.completedTasks,
    required this.totalTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = totalTasks == 0 ? 0.0 : completedTasks / totalTasks;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100, width: 1.0),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: avatarColor ?? Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: imagePath.isNotEmpty
                ? ClipOval(
                    child: Image.asset(
                      imagePath,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      avatarText ?? name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 16),

          // Name and Progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '$points pts',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Progress Bar
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        borderRadius: BorderRadius.circular(5),
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    Text(
                      '$completedTasks/$totalTasks done',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
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
  }
}
