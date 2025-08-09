import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullNameController = TextEditingController(text: 'Alex Johnson');
  final TextEditingController _emailController = TextEditingController(text: 'alex@example.com');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        // Profile Picture
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              child: const Text(
                'A',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            TextButton.icon(
              onPressed: _changePhoto,
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Change Photo'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Full Name
        _buildTextField('Full Name', _fullNameController),
        const SizedBox(height: 12),
        // Email Address
        _buildTextField('Email Address', _emailController),
        const SizedBox(height: 16),
        // Save Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7A1FA0),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Save Profile Changes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  void _changePhoto() {
    // Handle photo change logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo change functionality to be implemented')),
    );
  }

  void _saveProfile() {
    // Handle save profile logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}