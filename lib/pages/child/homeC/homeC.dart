import 'package:flutter/material.dart';
import 'home_page/home_stats.dart';
import 'home_page/home_task_card.dart';
import 'home_page/home_points_card.dart';

class HomeC extends StatefulWidget {
  const HomeC({super.key});

  @override
  State<HomeC> createState() => _HomeCState();
}

class _HomeCState extends State<HomeC> {
  List<bool> doneStates = [true, false, false, false]; // Added 4th card state

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      
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
            child: const HomeStats(),
          ),
          const SizedBox(height: 24),

          // Task Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                HomeTaskCard(
                  color: const Color(0xFFBF76FF),
                  icon: Icons.cleaning_services,
                  iconColor: Colors.white,
                  category: 'cleaning',
                  points: 30,
                  title: 'Tidy up your room',
                  done: doneStates[0],
                  onCheck: () {
                    setState(() {
                      doneStates[0] = !doneStates[0];
                    });
                  },
                ),
                const SizedBox(height: 16),
                HomeTaskCard(
                  color: const Color(0xFFFB5FB3),
                  icon: Icons.medical_services,
                  iconColor: Colors.white,
                  category: 'personal',
                  points: 15,
                  title: 'Brush your teeth',
                  done: doneStates[1],
                  onCheck: () {
                    setState(() {
                      doneStates[1] = !doneStates[1];
                    });
                  },
                ),
                const SizedBox(height: 16),
                HomeTaskCard(
                  color: const Color(0xFF4D9FFF),
                  icon: Icons.menu_book,
                  iconColor: Colors.white,
                  category: 'learning',
                  points: 25,
                  title: 'Do your homework',
                  done: doneStates[2],
                  onCheck: () {
                    setState(() {
                      doneStates[2] = !doneStates[2];
                    });
                  },
                ),
                const SizedBox(height: 16),
                HomeTaskCard(
                  color: const Color(0xFF76E5FF),
                  icon: Icons.local_dining,
                  iconColor: Colors.white,
                  category: 'helping',
                  points: 20,
                  title: 'Do the house chores',
                  done: doneStates[3],
                  onCheck: () {
                    setState(() {
                      doneStates[3] = !doneStates[3];
                    });
                  },
                ),
              ],
            ),
          ),

          HomePointsCard(points: 30, completed: 1, total: 4),
        ],
      ),
    );
  }
}