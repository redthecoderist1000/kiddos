import 'package:flutter/material.dart';
import 'recentActTile.dart';

class RecentAct extends StatelessWidget {
  const RecentAct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.access_time,
                  color: Colors.blue.shade400,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Activity List
          const RecentActTile(
            name: 'Lily',
            task: 'Clean your room',
            timeAgo: '30 mins ago',
            points: 20,
          ),
          const RecentActTile(
            name: 'Max',
            task: 'Do homework',
            timeAgo: '1 hour ago',
            points: 15,
          ),
          const RecentActTile(
            name: 'Ben',
            task: 'Feed the dog',
            timeAgo: '2 hours ago',
            points: 10,
          ),
          const RecentActTile(
            name: 'Sophie',
            task: 'Water plants',
            timeAgo: '3 hours ago',
            points: 10,
          ),
        ],
      ),
    );
  }
}