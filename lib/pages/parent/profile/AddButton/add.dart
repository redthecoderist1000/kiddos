import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddFamilyButton extends StatelessWidget {
  const AddFamilyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    detectQr(BarcodeCapture barcode) async {
      // Handle QR code detection logic here
      final childId = barcode.barcodes.first.rawValue;

      try {
        await supabase
            .from('tbl_user')
            .update({'parent_id': supabase.auth.currentUser!.id})
            .eq('id', childId!);

        context.pop();
        setSnackBar(
          'Your child account is linked successfully!',
          context,
          Colors.green,
        );
      } catch (e) {
        context.pop();
        setSnackBar(
          'Failed to link child account. Please try again.',
          context,
          Colors.red,
        );
      }
    }

    scanQr(BuildContext context) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Scan QR Code'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: MobileScanner(
                    onDetect: detectQr,
                    scanWindow: Rect.fromLTWH(0, 0, 300, 300),
                    errorBuilder: (context, error) {
                      return Center(
                        child: Text('Error occurred while scanning QR code'),
                      );
                    },
                  ),
                ),

                Text('QR Code scanning functionality goes here.'),
              ],
            ),
            actions: [
              TextButton(onPressed: () => context.pop(), child: Text('Close')),
            ],
          );
        },
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 77, 27, 175),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        onPressed: () => scanQr(context),
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
