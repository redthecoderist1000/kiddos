import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('login page (login.dart)'),

        MaterialButton(
          onPressed: () {
            context.go('/home-parent');
          },
          elevation: 0,
          textColor: Colors.white,
          color: Colors.deepPurpleAccent,
          child: Text('login (parent)'),
        ),
        MaterialButton(
          onPressed: () {},
          elevation: 0,
          textColor: Colors.white,
          color: Colors.deepPurple,
          child: Text('login (child)'),
        ),
      ],
    );
  }
}
