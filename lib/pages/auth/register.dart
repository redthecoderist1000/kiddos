import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  submit() {
    context.push('/otp');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('register page (register.dart)'),
        MaterialButton(
          onPressed: submit,
          elevation: 0,
          textColor: Colors.white,
          color: Colors.deepPurple,
          child: Text('submit btn'),
        ),
      ],
    );
  }
}
