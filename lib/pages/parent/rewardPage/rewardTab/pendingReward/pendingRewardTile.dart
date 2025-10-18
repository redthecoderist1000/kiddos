import 'package:flutter/material.dart';

class PendingRewardTile extends StatelessWidget {
  final String childName;
  final String rewardTitle;
  final String description;
  final int points;
  final String requestedDate;
  final String category;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const PendingRewardTile({
    Key? key,
    required this.childName,
    required this.rewardTitle,
    required this.description,
    required this.points,
    required this.requestedDate,
    required this.category,
    this.onApprove,
    this.onReject,
  }) : super(key: key);

  // Get different colors for each child (now used for accents)
  Color _getPersonColor(String name) {
    switch (name.toLowerCase()) {
      case 'emma':
        return const Color(0xFFE91E63); // Pink
      case 'max':
        return const Color(0xFF2196F3); // Blue
      case 'lily':
        return const Color(0xFF9C27B0); // Purple
      case 'ben':
        return const Color(0xFFFF9800); // Orange
      case 'sophie':
        return const Color(0xFF4CAF50); // Green
      default:
        // Generate a color based on the first letter
        int colorIndex = name.isNotEmpty ? name.codeUnitAt(0) % 6 : 0;
        List<Color> defaultColors = [
          const Color(0xFFE91E63), // Pink
          const Color(0xFF2196F3), // Blue
          const Color(0xFF9C27B0), // Purple
          const Color(0xFFFF9800), // Orange
          const Color(0xFF4CAF50), // Green
          const Color(0xFFF44336), // Red
        ];
        return defaultColors[colorIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    final personColor = _getPersonColor(childName);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with child info and category
          Row(
            children: [
              // Child avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: personColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    childName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Child name and time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      childName,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      requestedDate,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: personColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: personColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      color: personColor,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      category.toLowerCase(),
                      style: TextStyle(
                        color: personColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Reward info with icon - Now enclosed in border
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: Column(
              children: [
                // Reward details with icon
                Row(
                  children: [
                    // Reward icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: personColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(category),
                        color: personColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Reward details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rewardTitle,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Points display
                Row(
                  children: [
                    Icon(
                      Icons.stars,
                      color: personColor,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$points points',
                      style: TextStyle(
                        color: personColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              // Deny button
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: TextButton.icon(
                    onPressed: onReject,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.shade600,
                      size: 16,
                    ),
                    label: Text(
                      'Deny',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Approve button
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton.icon(
                    onPressed: onApprove,
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                    label: const Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'privileges':
        return Icons.star;
      case 'toys':
        return Icons.toys;
      case 'treats':
        return Icons.icecream;
      case 'activities':
        return Icons.movie;
      case 'others':
        return Icons.more_horiz;
      default:
        return Icons.card_giftcard;
    }
  }
}