import 'package:flutter/material.dart';

class EditFamilyMemberDialog extends StatefulWidget {
  final Map<String, dynamic> member;
  final void Function(Map<String, dynamic> updatedMember) onSave;

  const EditFamilyMemberDialog({
    super.key,
    required this.member,
    required this.onSave,
  });

  @override
  State<EditFamilyMemberDialog> createState() => _EditFamilyMemberDialogState();
}

class _EditFamilyMemberDialogState extends State<EditFamilyMemberDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late String role;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.member['name']);
    emailController = TextEditingController(text: widget.member['email']);
    role = widget.member['roleLabel'] ?? 'Parent';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Family Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 12),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: role,
            items: [
              DropdownMenuItem(value: 'Parent', child: Text('Parent')),
              DropdownMenuItem(value: 'Child', child: Text('Child')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => role = value);
            },
            decoration: InputDecoration(labelText: 'Role'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedMember = Map<String, dynamic>.from(widget.member);
            updatedMember['name'] = nameController.text;
            updatedMember['email'] = emailController.text;
            updatedMember['roleLabel'] = role;
            updatedMember['role'] = role.toLowerCase();
            Navigator.of(context).pop();
            widget.onSave(updatedMember);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}