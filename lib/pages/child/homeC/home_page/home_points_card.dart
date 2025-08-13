import 'package:flutter/material.dart';

class HomePointsCard extends StatelessWidget {
  final int points;
  final int completed;
  final int total;

  const HomePointsCard({
    super.key,
    this.points = 10,     
    this.completed = 1,    
    this.total = 3,        
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
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
              const Icon(Icons.star, color: Color(0xFFFFC700)),
              Text(
                ' $completed of $total ',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              const Icon(Icons.star, color: Color(0xFFFFC700)),
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
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Color(0xFFF8F2FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$points points earned!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB050FF),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('🎉', style: TextStyle(fontSize: 22)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Keep up the great work!',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB050FF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}