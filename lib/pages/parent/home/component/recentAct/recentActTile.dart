import 'package:flutter/material.dart';

class RecentActTile extends StatelessWidget {
  final dynamic data;

  const RecentActTile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getTimeFromTimestamp(String timestamp) {
      DateTime activityTime = DateTime.parse(timestamp).toLocal();
      Duration difference = DateTime.now().difference(activityTime);

      if (difference.inMinutes < 1) {
        return 'just now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inDays} days ago';
      }
    }

    getAction(String status) {
      switch (status) {
        case 'Assigned':
          return 'was assigned a task';
        case 'Under Review':
          return 'submitted a task for review';
        case 'Completed':
          return 'completed a task';
        case 'Requested':
          return 'requested a reward';
        case 'Accepted':
          return 'recieved a reward';
        case 'Rejected':
          return 'had a reward request rejected';
        default:
          return 'performed an action';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 1.0),
        ),
        child: Row(
          children: [
            // Activity info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and status
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: data['user_name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: ' ${getAction(data['status'])}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Task description
                  Text(
                    data['reference_name'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Time ago
                  Text(
                    getTimeFromTimestamp(data['updated_at']),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),

            // Points badge
            data['points_earned'] == null
                ? Container()
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '+${data['points_earned']} pts',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
