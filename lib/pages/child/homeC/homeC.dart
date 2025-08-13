import 'package:flutter/material.dart';
import 'home_page/home_stats.dart';
import 'home_page/home_task_card.dart';
import 'home_page/home_points_card.dart';
import 'home_page/home_header.dart';

class HomeC extends StatefulWidget {
  const HomeC({super.key});

  @override
  State<HomeC> createState() => _HomeCState();
}

class _HomeCState extends State<HomeC> {
  List<bool> doneStates = [true, false, false]; // Example for 3 cards

  // Example backend data
  final String userName = "Miah";
  final String greetingEmoji = "👋";
  final String scheduleText = "Here's what's on your schedule today.";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (now separated and backend-friendly)
          HomeHeader(
            name: userName,
            greeting: greetingEmoji,
            subtitle: scheduleText,
          ),
          const SizedBox(height: 24),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: const HomeStats(),
          ),
          const SizedBox(height: 24),

          // Task Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                  color: const Color(0xFF4D9FFF),
                  icon: Icons.menu_book,
                  iconColor: Colors.white,
                  category: 'learning',
                  points: 25,
                  title: 'Do your activities',
                  done: doneStates[2],
                  onCheck: () {
                    setState(() {
                      doneStates[2] = !doneStates[2];
                    });
                  },
                ),
              ],
            ),
          ),
          const HomePointsCard(), 
        ],
      ),
    );
  }
}