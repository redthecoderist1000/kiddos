import 'package:flutter/material.dart';

import 'familyMemberList.dart';
import 'familyCount.dart';
import 'AddButton/add.dart';
import 'EditButton/edit.dart';

class ProfileP extends StatefulWidget {
  const ProfileP({super.key});

  @override
  State<ProfileP> createState() => ProfilePState();
}

class ProfilePState extends State<ProfileP> {
  List<Map<String, dynamic>> members = [
    {
      'initial': 'S',
      'name': 'Sarah Geronimo',
      'email': 'sg@gmail.com',
      'role': 'parent',
      'roleColor': Color(0xFFBFA2F7),
      'roleLabel': 'Parent',
      'roleLabelColor': Color(0xFF8B3EFF),
    },
    {
      'initial': 'A',
      'name': 'Anteh Geronimo',
      'email': 'ag@gmail.com',
      'role': 'child',
      'roleColor': Color(0xFFFFF3C2),
      'roleLabel': 'Child',
      'roleLabelColor': Color(0xFFFFC700),
      'age': '8',
    },
  ];

  void _addMember(Map<String, dynamic> member) {
    setState(() {
      members.add(member);
    });
  }

  void _editMember(int index, Map<String, dynamic> updatedMember) {
    setState(() {
      members[index] = updatedMember;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Users',
          style: TextStyle(
            fontSize: isSmall ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B3EFF),
          ),
        ),
        SizedBox(height: isSmall ? 4 : 8),
        Text(
          "Manage your Kiddo's family",
          style: TextStyle(fontSize: isSmall ? 13 : 16, color: Colors.black87),
        ),
        SizedBox(height: isSmall ? 16 : 28),
        AddFamilyButton(
          onMemberAdded: () async {
            // TODO: addmember logic;
          },
        ),
        SizedBox(height: isSmall ? 16 : 24),
        FamilyMemberList(
          members: members,
          isSmall: isSmall,
          onEdit: (index, member) {
            showDialog(
              context: context,
              builder: (context) => EditFamilyMemberDialog(
                member: member,
                onSave: (updatedMember) {
                  _editMember(index, updatedMember);
                },
              ),
            );
          },
        ),
        SizedBox(height: isSmall ? 20 : 32),
        FamilyCount(isSmall: isSmall),
      ],
    );
  }
}
