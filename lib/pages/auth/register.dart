import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/components/Snackbar.dart';
import 'package:kiddos/components/auth/AuthService.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService authService = AuthService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _role = "Parent";

  var formKey = GlobalKey<FormState>();
  final unameCon = TextEditingController();
  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final confirmPassCon = TextEditingController();

  void submit() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await authService.signUp(
        context,
        emailCon.text,
        passCon.text,
        unameCon.text,
        _role,
      );
      setSnackBar('Successfully registered!', context, Colors.green);
      context.go('/auth');
    } catch (e) {
      setSnackBar(e.toString(), context, Colors.red);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    unameCon.dispose();
    emailCon.dispose();
    passCon.dispose();
    confirmPassCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Logo
              Image.asset('assets/KiddosLogo.png', height: 250),
              const SizedBox(height: 10),

              // Heading
              const Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9F86C0), // pastel purple
                ),
              ),
              const SizedBox(height: 20),

              // Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: unameCon,
                  decoration: InputDecoration(
                    hintText: "Name",
                    filled: true,
                    fillColor: Color(0xFFF8DDF0), // light pink
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your username'
                      : null,
                ),
              ),
              const SizedBox(height: 10),

              // Role selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: "Parent",
                      groupValue: _role,
                      activeColor: Color(0xFF9F86C0),
                      onChanged: (value) {
                        setState(() {
                          _role = value!;
                        });
                      },
                    ),
                    const Text("Parent"),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: "Child",
                      groupValue: _role,
                      activeColor: Color(0xFF9F86C0),
                      onChanged: (value) {
                        setState(() {
                          _role = value!;
                        });
                      },
                    ),
                    const Text("Child"),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: emailCon,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Color(0xFFF8DDF0),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your email'
                      : null,
                ),
              ),
              const SizedBox(height: 10),

              // Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: passCon,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Color(0xFFF8DDF0),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Confirm Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: confirmPassCon,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    filled: true,
                    fillColor: Color(0xFFF8DDF0),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passCon.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Register button
              SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9F86C0), // pastel purple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
