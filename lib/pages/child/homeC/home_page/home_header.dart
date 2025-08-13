import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String greeting;
  final String subtitle;

  const HomeHeader({
    super.key,
    required this.name,
    this.greeting = '👋',
    this.subtitle = "Here's what's on your schedule today.",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Hello $name!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9810FA),
              ),
            ),
            const SizedBox(width: 8),
            Text(greeting, style: const TextStyle(fontSize: 28)),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}