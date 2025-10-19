import 'package:flutter/material.dart';

setSnackBar(String message, BuildContext context, Color color) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
