import 'package:flutter/material.dart';

class TaskPageLeadP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F9FF), // Light background
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with circle
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check_circle_outline,
                color: Color(0xFF2972FE),
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 12),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Management',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Create and manage tasks for your children',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(width: 16),
          // // Smaller gradient button on the right
          // Container(
          //   height: 32,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Color(0xFF2972FE), Color(0xFF6D5DF6)],
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //     ),
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black12,
          //         blurRadius: 6,
          //         offset: Offset(0, 2),
          //       ),
          //     ],
          //   ),
          //   child: TextButton.icon(
          //     onPressed: () {},
          //     icon: Icon(Icons.add, color: Colors.white, size: 18),
          //     label: Text(
          //       'New Task',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 13,
          //       ),
          //     ),
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.symmetric(horizontal: 10),
          //       minimumSize: Size(0, 32),
          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       backgroundColor: Colors.transparent,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}