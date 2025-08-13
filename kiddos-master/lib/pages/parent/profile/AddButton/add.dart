import 'package:flutter/material.dart';
import 'AddEmail.dart';
import 'AddCode.dart';

class AddFamilyButton extends StatelessWidget {
  final VoidCallback onMemberAdded;

  const AddFamilyButton({super.key, required this.onMemberAdded});

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Family Member',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 12),
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