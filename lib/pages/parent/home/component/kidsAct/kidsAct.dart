import 'package:flutter/material.dart';
import 'kidsActTile.dart';

class KidsAct extends StatelessWidget {
  const KidsAct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: Colors.pink.shade300,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Kids Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Kids List
          const KidsActTile(
            name: 'Lily',
            avatarColor: Colors.purple,
            avatarText: 'L',
            points: 245,
            completedTasks: 8,
            totalTasks: 12,
          ),
          const KidsActTile(
            name: 'Max',
            avatarColor: Colors.purple,
            avatarText: 'M',
            points: 190,
            completedTasks: 6,
            totalTasks: 12,
          ),
          const KidsActTile(
            name: 'Ben',
            avatarColor: Colors.purple,
            avatarText: 'B',
            points: 120,
            completedTasks: 5,
            totalTasks: 12,
          ),
          const KidsActTile(
            name: 'Sophie',
            avatarColor: Colors.purple,
            avatarText: 'S',
            points: 90,
            completedTasks: 4,
            totalTasks: 12,
          ),
        ],
      ),
    );
  }
}