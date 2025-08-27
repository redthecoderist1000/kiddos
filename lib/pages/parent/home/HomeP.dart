import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

import 'carouselP.dart';
import 'familyPerp.dart';
import 'homeStat.dart';
import 'recentAct.dart';
import 'topHeader.dart';
import '../createTask/createTask.dart';

class HomeP extends StatefulWidget {
  const HomeP({super.key});

  @override
  State<HomeP> createState() => HomePState();
}

class HomePState extends State<HomeP> {
  int _currentSlide = 0;
  Timer? _timer;
  final PageController _pageController = PageController();

  final List<Map<String, String>> _slides = [
    {
      'title': 'Monitor Family Progress',
      'subtitle':
          'Track your children\'s task completion and celebrate their achievement in real-time.',
    },
    {
      'title': 'Create & Assign Tasks',
      'subtitle':
          'Easily create new tasks and assign them to family members with just a few taps.',
    },
    {
      'title': 'Reward System',
      'subtitle':
          'Motivate your children with points and rewards for completing their daily tasks.',
    },
    {
      'title': 'Family Analytics',
      'subtitle':
          'View detailed insights about your family\'s productivity and task completion rates.',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted && _pageController.hasClients) {
        final nextSlide = (_currentSlide + 1) % _slides.length;
        _pageController.animateToPage(
          nextSlide,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const SizedBox(height: 24),
          HomeCarousel(
            currentSlide: _currentSlide,
            pageController: _pageController,
            slides: _slides,
            onPageChanged: (index) {
              if (mounted) {
                setState(() {
                  _currentSlide = index;
                });
              }
            },
          ),
          const SizedBox(height: 24),
          const HomeStats(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateTask(),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Create Task',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const HomeFamilyPerformance(),
          const SizedBox(height: 24),
          const HomeRecentActivity(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
