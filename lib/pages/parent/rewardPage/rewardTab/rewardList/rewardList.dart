import 'package:flutter/material.dart';
import 'package:kiddos/components/Button.dart';
import 'rewardListTile.dart';
import 'addRewardModal.dart';

class RewardList extends StatefulWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  String selectedCategory = 'All';
  
  final List<String> categories = [
    'All',
    'Privileges',
    'Toys', 
    'Treats',
    'Activities',
    'Others'
  ];

  final List<Map<String, dynamic>> allRewards = [
    {
      'category': 'Privileges',
      'points': 50,
      'title': 'Extra Playtime',
      'description': '30 minutes of extra playtime',
    },
    {
      'category': 'Treats',
      'points': 25,
      'title': 'Ice Cream',
      'description': 'Choose your favorite flavor',
    },
    {
      'category': 'Activities',
      'points': 75,
      'title': 'Movie Night',
      'description': 'Pick any movie for family night',
    },
    {
      'category': 'Privileges',
      'points': 30,
      'title': 'Stay Up Late',
      'description': '1 hour past bedtime on weekend',
    },
    {
      'category': 'Toys',
      'points': 100,
      'title': 'New Action Figure',
      'description': 'Choose from the toy store',
    },
    {
      'category': 'Others',
      'points': 40,
      'title': 'Special Breakfast',
      'description': 'Pancakes with your favorite toppings',
    },
  ];

  List<Map<String, dynamic>> get filteredRewards {
    if (selectedCategory == 'All') {
      return allRewards;
    }
    return allRewards.where((reward) => reward['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create New Reward Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
          
          // Reward List - Now properly scrollable
          ...filteredRewards.map((reward) => RewardListTile(
            category: reward['category'].toString().toLowerCase(),
            points: reward['points'] as int,
            title: reward['title'] as String,
            description: reward['description'] as String,
            backgroundColor: _getCategoryColor(reward['category'] as String),
            icon: _getCategoryIcon(reward['category'] as String),
          )).toList(),
        ],
      ),
    );
  }

  void _showCreateRewardModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddRewardModal(
          onRewardAdded: (newReward) {
            setState(() {
              allRewards.add(newReward);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reward created successfully!')),
            );
          },
        );
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