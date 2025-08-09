import 'package:flutter/material.dart';
import 'edit_account.dart';
import 'change_password.dart';
import 'delete_account.dart';

class SettingsP extends StatefulWidget {
  const SettingsP({super.key});

  @override
  State<SettingsP> createState() => _SettingsPState();
}

class _SettingsPState extends State<SettingsP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7A1FA0),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Manage your kiddo's account and preferences",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Edit Profile Section
            _buildSection(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              subtitle: 'Update your personal information and profile picture',
              child: const EditProfile(),
            ),
            
            const SizedBox(height: 20),
            
            // Change Password Section
            _buildSection(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your password to keep your account secure',
              child: const ChangePassword(),
            ),
            
            const SizedBox(height: 20),
            
            // Delete Account Section
            const DeleteAccount(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          child,
        ],
      ),
    );
  }
}