import 'package:flutter/material.dart';
import 'package:kiddos/components/Button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'rewardListTile.dart';
import 'addRewardModal.dart';

class RewardList extends StatefulWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  final supabase = Supabase.instance.client;
  final rewardChannel = Supabase.instance.client.channel('public:tbl_reward');
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Privileges',
    'Toys',
    'Treats',
    'Activities',
    'Others',
  ];

  Future<dynamic> loadRewards() async {
    try {
      var query = supabase.from('vw_rewardlistp').select('*');

      if (selectedCategory != 'All') {
        query = query.eq('category', selectedCategory);
      }

      final res = await query.order('points', ascending: false);

      return res;
    } catch (e) {
      throw Exception('Failed to load rewards.');
    }
  }

  @override
  void initState() {
    super.initState();
    rewardChannel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'tbl_reward',
          callback: (payload) {
            setState(() {});
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    supabase.removeChannel(rewardChannel);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create New Reward Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Create New Reward',
                  icon: Icons.add,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  onPressed: () {
                    _showCreateRewardModal();
                  },
                ),
              ),
            ),

            // Category Filter
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: FilterChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey.shade200,
                      checkmarkColor: Colors.white,
                      elevation: isSelected ? 2 : 0,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            FutureBuilder(
              future: loadRewards(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                }

                if (asyncSnapshot.hasError) {
                  return SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(child: Text('${asyncSnapshot.error}'))],
                    ),
                  );
                }

                final rewards = asyncSnapshot.data;

                // No rewards available
                if (rewards == null || (rewards as List).isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No rewards available in this category.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rewards.length,
                  itemBuilder: (context, index) {
                    final reward = rewards[index];
                    return RewardListTile(
                      category: reward['category'].toString().toLowerCase(),
                      points: reward['points'] as int,
                      title: reward['title'] as String,
                      description: reward['description'] ?? '',
                      backgroundColor: _getCategoryColor(
                        reward['category'] as String,
                      ),
                      icon: _getCategoryIcon(reward['category'] as String),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateRewardModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddRewardModal();
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Privileges':
        return const Color(0xFF2196F3); // Blue
      case 'Toys':
        return const Color(0xFFF44336); // Red
      case 'Treats':
        return const Color(0xFF4CAF50); // Green
      case 'Activities':
        return const Color(0xFFFF9800); // Orange
      case 'Others':
        return const Color(0xFF9C27B0); // Purple
      default:
        return const Color(0xFF607D8B); // Blue Grey
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Privileges':
        return Icons.star;
      case 'Toys':
        return Icons.toys;
      case 'Treats':
        return Icons.icecream;
      case 'Activities':
        return Icons.movie;
      case 'Others':
        return Icons.more_horiz;
      default:
        return Icons.help_outline;
    }
  }
}
