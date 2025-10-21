import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:kiddos/pages/child/homeC/home_page/home_points_card.dart';
import 'package:kiddos/pages/child/homeC/home_page/home_task_card.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../db/task_database_helper.dart';
import '../../../models/task.dart';
import 'home_page/home_stats.dart';

class HomeC extends StatefulWidget {
  const HomeC({super.key});

  @override
  State<HomeC> createState() => _HomeCState();
}

class _HomeCState extends State<HomeC> {
  final supabase = Supabase.instance.client;
  List<bool> doneStates = [];

  @override
  void initState() {
    super.initState();
  }

  Color _getCardColor(String category) {
    switch (category) {
      case 'cleaning':
        return const Color(0xFFBF76FF);
      case 'personal':
        return const Color(0xFFFB5FB3);
      case 'learning':
        return const Color(0xFF4D9FFF);
      case 'helping':
        return const Color(0xFF76E5FF);
      default:
        return Colors.grey;
    }
  }

  String _getCardEmoji(String category) {
    switch (category) {
      case 'cleaning':
        return '🧹';
      case 'personal':
        return '🧴';
      case 'learning':
        return '📚';
      case 'helping':
        return '🤝';
      default:
        return '❓';
    }
  }

  Future<dynamic> loadData() async {
    try {
      final res = await supabase
          .from('vw_alltaskperchild')
          .select()
          .eq('status', 'Assigned');
      return res;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KiddosProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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
                    Text(
                      'Hello ${provider.userDetails?['user_name']}!',
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
                Text(
                  "Welcome to your task adventure!",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: HomeStats(),
            ),
            const SizedBox(height: 24),

            FutureBuilder(
              future: loadData(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                } else if (asyncSnapshot.hasData &&
                    asyncSnapshot.data.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [Color(0xFFFFF7E6), Color(0xFFFDEBFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xFFFFD700),
                              size: 48,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Ready for Adventure!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9810FA),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "No tasks assigned yet, but don't worry! Your parents will add some fun tasks for you to complete soon.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 24),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.track_changes,
                                    color: Color(0xFFFB5FB3),
                                    size: 32,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Coming Soon!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFB5FB3),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Tasks will appear here when your parents add them. Get ready to earn points and have fun!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                final tasks = asyncSnapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Tasks Today",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9810FA),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go(
                              '/task-child',
                            ); // <-- This navigates to the child task page with bottom navigation
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                              color: Color(0xFF9810FA),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final item = tasks[index];
                        return HomeTaskCard(
                          color: _getCardColor(item['category']),
                          emoji: _getCardEmoji(item['category']),
                          category: item['category'],
                          points: item['points'],
                          title: item['task_name'],
                          done: false,
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            // Points Card
            // HomePointsCard(
            //   points: tasks.isEmpty ? 0 : pointsEarned,
            //   completed: tasks.isEmpty ? 0 : tasksDone,
            //   total: tasks.isEmpty ? 0 : tasks.length,
            // ),
          ],
        ),
      ),
    );
  }
}
