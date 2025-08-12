import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class GenerateInviteCodeWidget extends StatefulWidget {
  const GenerateInviteCodeWidget({super.key});

  @override
  State<GenerateInviteCodeWidget> createState() => _GenerateInviteCodeWidgetState();
}

class _GenerateInviteCodeWidgetState extends State<GenerateInviteCodeWidget> {
  String? _inviteCode;
  String _role = 'Parent';

  String _generateCode() {
    // random 6-character code
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = Random();
    return List.generate(6, (index) => chars[rand.nextInt(chars.length)]).join();
  }

  void _onGeneratePressed() {
    setState(() {
      _inviteCode = _generateCode();
    });
  }

  void _onCopyPressed() {
    if (_inviteCode != null) {
      Clipboard.setData(ClipboardData(text: _inviteCode!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code copied to clipboard!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isSmall = mq.size.width < 400;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 40, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isSmall ? 16 : 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Generate Invite Code',
                style: TextStyle(
                  fontSize: isSmall ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isSmall ? 12 : 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Role',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: isSmall ? 13 : 15),
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _role,
                items: [
                  DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                  DropdownMenuItem(value: 'Child', child: Text('Child')),
                ],
                onChanged: (value) => setState(() => _role = value ?? 'Parent'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              SizedBox(height: isSmall ? 14 : 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onGeneratePressed,
                  child: Text('Generate Code'),
                ),
              ),
              SizedBox(height: isSmall ? 14 : 20),
              if (_inviteCode != null) ...[
                SelectableText(
                  '$_inviteCode',
                  style: TextStyle(
                    fontSize: isSmall ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.copy),
                    label: Text('Copy Code'),
                    onPressed: _onCopyPressed,
                  ),
                ),
              ],
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}