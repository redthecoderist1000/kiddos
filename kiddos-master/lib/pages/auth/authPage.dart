import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kiddos/pages/auth/login.dart';
import 'package:kiddos/pages/auth/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            spacing: 20,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: isRegister ? Register() : Login(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: isRegister
                          ? 'Already have an account? '
                          : 'Don\'t have an account yet? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isRegister = !isRegister;
                              });
                            },
                          text: isRegister ? 'Login' : 'Register',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
