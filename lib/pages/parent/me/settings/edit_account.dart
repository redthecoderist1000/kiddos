import 'package:flutter/material.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final supabase = Supabase.instance.client;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController unameCon;

  @override
  void initState() {
    super.initState();
    unameCon = TextEditingController();
  }

  @override
  void dispose() {
    unameCon.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    // check if username is changed
    final provider = Provider.of<KiddosProvider>(context, listen: false);
    if (unameCon.text == provider.userDetails?['user_name']) {
      setSnackBar('No changes detected.', context, Colors.orange);
      return;
    }

    try {
      await supabase
          .from('tbl_user')
          .update({'user_name': unameCon.text})
          .eq('id', supabase.auth.currentUser!.id);

      // Update local user details in provider
      provider.updateUserDetails({'user_name': unameCon.text});
      setSnackBar('User detail updated successfully!', context, Colors.green);
    } catch (e) {
      setSnackBar('Failed to update user detail.', context, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KiddosProvider>(context);
    unameCon = TextEditingController(
      text: provider.userDetails?['user_name'] ?? '',
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Profile Picture
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                child: Text(
                  provider.userDetails?['user_name'][0] ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: _changePhoto,
                icon: const Icon(Icons.camera_alt_outlined),
                label: Text('Change Photo'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // User Name
          _buildTextField('User Name', unameCon),
          const SizedBox(height: 12),
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
      ),
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
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          validator: (value) {
            if (value?.trim() == null || value!.trim().isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _changePhoto() {
    // Handle photo change logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Photo change functionality to be implemented'),
      ),
    );
  }
}
