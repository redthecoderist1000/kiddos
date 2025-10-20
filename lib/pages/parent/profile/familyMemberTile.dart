import 'package:flutter/material.dart';

class FamilyMemberTile extends StatelessWidget {
  final String name;
  final String email;
  final bool isSmall;

  const FamilyMemberTile({
    super.key,
    required this.name,
    required this.email,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 12,
        vertical: isSmall ? 6 : 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isSmall ? 16 : 22,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              name.isNotEmpty ? name[0] : '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isSmall ? 14 : 20,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: isSmall ? 8 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmall ? 13 : 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: isSmall ? 4 : 8),
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: isSmall ? 6 : 8,
                    //     vertical: isSmall ? 1 : 2,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: roleColor,
                    //     borderRadius: BorderRadius.circular(isSmall ? 6 : 8),
                    //   ),
                    //   child: Text(
                    //     roleLabel,
                    //     style: TextStyle(
                    //       color: roleLabelColor,
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: isSmall ? 10 : 12,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: isSmall ? 1 : 2),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: isSmall ? 11 : 13,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
