import 'package:flutter/material.dart';

// Data model for a family member
class FamilyMemberPerformance {
  final String name;
  final String subtitle;
  final String progress;

const FamilyMemberPerformance({
    required this.name,
    required this.subtitle,
    required this.progress,
  });
}

class HomeFamilyPerformance extends StatelessWidget {
  final List<FamilyMemberPerformance> members;

  const HomeFamilyPerformance({
    super.key,
    this.members = const [
      FamilyMemberPerformance(name: 'Emma', subtitle: '4 tasks completed', progress: '4/12'),
      FamilyMemberPerformance(name: 'Max', subtitle: '3 tasks completed', progress: '3/12'),
      FamilyMemberPerformance(name: 'Sophie', subtitle: '5 tasks completed', progress: '1/12'),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.trending_up, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                'Family Performance',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (var member in members) ...[
            _buildFamilyMember(member.name, member.subtitle, member.progress),
            if (member != members.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  static Widget _buildFamilyMember(String name, String subtitle, String progress) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey[300],
          child: Text(
            name[0],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            progress,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
