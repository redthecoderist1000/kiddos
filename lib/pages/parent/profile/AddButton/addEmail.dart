import 'package:flutter/material.dart';

class AddFamilyButton extends StatelessWidget {
  final VoidCallback onMemberAdded;

  const AddFamilyButton({super.key, required this.onMemberAdded});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBFA2F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddFamilyDialog(onMemberAdded: onMemberAdded),
        ),
        icon: const Icon(Icons.group_add, color: Colors.white),
        label: const Text(
          'Add Family Member',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class AddFamilyDialog extends StatefulWidget {
  final VoidCallback onMemberAdded;

  const AddFamilyDialog({required this.onMemberAdded});

  @override
  State<AddFamilyDialog> createState() => _AddFamilyDialogState();
}

class _AddFamilyDialogState extends State<AddFamilyDialog> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _role = 'Parent';
  String _email = '';
  String _age = '';

  @override
  Widget build(BuildContext context) {
    final isChild = _role == 'Child';
    final media = MediaQuery.of(context);
    final isSmall = media.size.width < 400;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 40,
        vertical: isSmall ? 16 : 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400,
          minWidth: isSmall ? 0 : 320,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 24,
            vertical: isSmall ? 16 : 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // title
                  Text(
                    'Add New Family Member',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmall ? 16 : 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add a child or another parent to your family',
                    style: TextStyle(
                      fontSize: isSmall ? 12 : 13,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isSmall ? 12 : 18),
                  // full name
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Full Name *',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmall ? 13 : 14),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter full name',
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Full name required' : null,
                    onChanged: (value) => setState(() => _fullName = value),
                  ),
                  SizedBox(height: isSmall ? 10 : 14),
                  // role
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Role *',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmall ? 13 : 14),
                    ),
                  ),
                  SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: _role,
                    items: const [
                      DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                      DropdownMenuItem(value: 'Child', child: Text('Child')),
                    ],
                    onChanged: (value) => setState(() => _role = value ?? 'Parent'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  SizedBox(height: isSmall ? 10 : 14),
                  // email 
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email Address' + (_role == 'Parent' ? ' *' : ' (optional)'),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmall ? 13 : 14),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter email address',
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (_role == 'Parent' && (value == null || value.trim().isEmpty)) {
                        return 'Email required';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => _email = value),
                  ),
                  SizedBox(height: isSmall ? 10 : 14),
                  // age for child(
                  if (_role == 'Child') ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Age (optional)',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmall ? 13 : 14),
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '8',
                        filled: true,
                        fillColor: const Color(0xFFF6F6F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(() => _age = value),
                    ),
                    SizedBox(height: isSmall ? 12 : 18),
                  ] else ...[
                    SizedBox(height: isSmall ? 12 : 18),
                  ],
                  // button
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B3EFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onMemberAdded();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Add Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: isSmall ? 14 : 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF6F6F6)),
                        backgroundColor: const Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: isSmall ? 14 : 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}