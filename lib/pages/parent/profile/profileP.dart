import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'familyMemberList.dart';
import 'AddButton/add.dart';

class ProfileP extends StatefulWidget {
  const ProfileP({super.key});

  @override
  State<ProfileP> createState() => ProfilePState();
}

class ProfilePState extends State<ProfileP> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),

        child: Column(
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
              style: TextStyle(
                fontSize: isSmall ? 13 : 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: isSmall ? 16 : 28),
            AddFamilyButton(),

            SizedBox(height: isSmall ? 16 : 24),
            FamilyMemberList(isSmall: isSmall),
            // SizedBox(height: isSmall ? 20 : 32),
            // FamilyCount(isSmall: isSmall),
          ],
        ),
      ),
    );
  }
}
