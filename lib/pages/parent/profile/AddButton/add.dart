import 'package:flutter/material.dart';
import 'AddEmail.dart';
import 'AddCode.dart';

class AddFamilyButton extends StatelessWidget {
  final VoidCallback onMemberAdded;

  const AddFamilyButton({super.key, required this.onMemberAdded});

void _showAddOptions(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Align(
      alignment: Alignment.center, // <-- Center the popup
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add Family Member',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Choose how you'd like to add a family member",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.email),
                      label: Text('Add via Email'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B3EFF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => AddFamilyDialog(onMemberAdded: onMemberAdded),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 3),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.qr_code),
                      label: Text('Add via Code'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF8B3EFF),
                        side: BorderSide(color: Color(0xFF8B3EFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => GenerateInviteCodeWidget(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBFA2F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        onPressed: () => _showAddOptions(context),
        icon: Icon(Icons.group_add, color: Colors.white),
        label: Text(
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