import 'package:flutter/material.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ChildQR extends StatelessWidget {
  const ChildQR({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KiddosProvider>(context);

    return Center(
      child: QrImageView(
        data: provider.userDetails?['user_id'],
        version: QrVersions.auto,
        size: 300.0,
        errorStateBuilder: (cxt, err) {
          return Center(
            child: Text(
              'Uh oh! Something went wrong...',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
