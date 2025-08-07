import 'package:flutter/material.dart';

class SettingsP extends StatefulWidget {
  const SettingsP({super.key});

  @override
  State<SettingsP> createState() => _SettingsPState();
}

class _SettingsPState extends State<SettingsP> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Settings Page (parent)')],
    );
  }
}
