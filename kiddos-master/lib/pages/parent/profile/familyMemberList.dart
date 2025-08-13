import 'package:flutter/material.dart';
import 'FamilyMemberTile.dart';

class FamilyMemberList extends StatelessWidget {
  final List<Map<String, dynamic>> members;
  final bool isSmall;
  final void Function(int index, Map<String, dynamic> member) onEdit;

  const FamilyMemberList({
    required this.members,
    required this.isSmall,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 10 : 16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(isSmall ? 10 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: Colors.black87, size: isSmall ? 18 : 24),
              SizedBox(width: isSmall ? 4 : 8),
              Text(
                'Family Members (${members.length})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmall ? 13 : 16,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 2 : 4),
          Text(
            'Tap the edit icon to update member details',
            style: TextStyle(fontSize: isSmall ? 10 : 12, color: Colors.black54),
          ),
          SizedBox(height: isSmall ? 8 : 16),
          ...List.generate(members.length, (index) {
            final member = members[index];
            return Padding(
              padding: EdgeInsets.only(bottom: index == members.length - 1 ? 0 : (isSmall ? 8 : 12)),
              child: FamilyMemberTile(
                initial: member['initial'],
                name: member['name'],
                email: member['email'],
                role: member['role'],
                roleColor: member['roleColor'],
                roleLabel: member['roleLabel'],
                roleLabelColor: member['roleLabelColor'],
                onEdit: () => onEdit(index, member),
                isSmall: isSmall,
              ),
            );
          }),
        ],
      ),
    );
  }
}