import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:kiddos/components/auth/AuthService.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    signOut() {
      try {
        authService.signOut();
        context.go('/auth');
      } catch (e) {
        setSnackBar('Failed to sign out!', context, Colors.red);
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!),
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
              Icon(Icons.delete_outline, color: Colors.red[400]),
              const SizedBox(width: 8),
              Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Sign out from your account on this device.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: Colors.red[50],
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Warning:',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.red[600],
          //         ),
          //       ),
          //       const SizedBox(height: 4),
          //       Text(
          //         'This action cannot be undone. This will permanently delete your account, all your chore data, rewards, and remove you from all family groups.',
          //         style: TextStyle(fontSize: 12, color: Colors.red[600]),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: signOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
