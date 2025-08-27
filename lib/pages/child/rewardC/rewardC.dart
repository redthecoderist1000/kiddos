import 'package:flutter/material.dart';

class RewardC extends StatefulWidget {
  const RewardC({super.key});

  @override
  State<RewardC> createState() => _RewardCState();
}

class _RewardCState extends State<RewardC> {
  List tasks = []; // Add this line

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'My Rewards',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9810FA),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('🎁', style: TextStyle(fontSize: 28)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                tasks.isEmpty
                    ? "Complete tasks to earn points and claim amazing rewards!"
                    : "Spend your points on awesome rewards!",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
