import 'package:flutter/material.dart';

class HomePointsCard extends StatelessWidget {
  final int points;
  final int completed;
  final int total;

  const HomePointsCard({
    super.key,
    required this.points,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Color(0xFFFFC700)), // gold
              Text(
                '  $completed of $total  ',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              const Icon(Icons.star, color: Color(0xFFFFC700)), // gold
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'tasks completed today',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFF3E6FF), // soft purple
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                total == 0
                    ? Text(
                        'Ready to start! 🎉',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9810FA),
                        ),
                      )
                    : Text(
                        '$points points earned!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB050FF),
                        ),
                      ),
                const SizedBox(height: 6),
                Text(
                  total == 0
                      ? 'Your journey begins when tasks are added!'
                      : 'Keep going! You\'re doing great!',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9810FA),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}