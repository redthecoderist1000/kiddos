import 'package:flutter/material.dart';

class ProfileP extends StatefulWidget {
  const ProfileP({super.key});

  @override
  State<ProfileP> createState() => ProfilePState();
}

class ProfilePState extends State<ProfileP> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Profile Parent')],
    );
  }
}
