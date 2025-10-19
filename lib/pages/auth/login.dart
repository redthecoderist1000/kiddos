import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:kiddos/components/auth/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService authService = AuthService();

  bool _obscurePassword = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  var isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCon.dispose();
    passCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    login() async {
      if (!formKey.currentState!.validate()) return;

      try {
        setState(() {
          isLoading = true;
        });
        await authService.signIn(context, emailCon.text, passCon.text);
        context.go('/auth');
        setSnackBar('Logged In Successfully!', context, Colors.green);
      } on AuthException catch (e) {
        setSnackBar(e.message, context, Colors.red);
      } catch (e) {
        setSnackBar(e.toString(), context, Colors.red);
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top gradient background
            Container(
              height: 380,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA87FE0),
                    Color(0xFFF7B1D1),
                  ], // purple → pink
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(140),
                  bottomRight: Radius.circular(140),
                ),
              ),
            ),

            // Logo (overlapping gradient)
            Transform.translate(
              offset: const Offset(0, -50),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Image.asset('assets/KiddosLogo.png', height: 200),
              ),
            ),

            // Reduced gap between logo and LOGIN
            const SizedBox(height: 5),

            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 36, // Bigger
                    fontWeight: FontWeight.w900, // Extra bold
                    color: Color(0xFF7F5AA2), // pastel purple heading
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 15,
                  children: [
                    // Email field
                    TextFormField(
                      controller: emailCon,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Color(0xFFF8DDF0), // light pink
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Simple email validation
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    // Password field
                    TextFormField(
                      controller: passCon,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Color(0xFFF8DDF0), // light pink
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Login button
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9F86C0), // pastel purple
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Forgot password
            // TextButton(
            //   onPressed: () {
            //     context.push('/home-child');
            //   },
            //   child: const Text(
            //     "Forgot Password?",
            //     style: TextStyle(
            //       color: Color(0xFF4B8FBA), // light blue
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
