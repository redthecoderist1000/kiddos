import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  void _verifyOTP() {
    // Handle OTP verification here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top bar
              Container(
                color: const Color(0xFFF8DDF0), // light pink
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF9F86C0), // pastel purple
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9F86C0),
                ),
              ),
              const SizedBox(height: 12),

              // Icon (replace with your matching asset)
              Image.asset(
                'assets/phone_in_hand.png', // <-- Add your PNG in assets
                height: 160,
              ),
              const SizedBox(height: 16),

              // Subtitle
              const Text(
                "A one-time password will be sent to\nyour email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFB09FCA), // softer purple
                ),
              ),
              const SizedBox(height: 20),

              // OTP fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 45,
                      height: 50,
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Resend OTP
              GestureDetector(
                onTap: () {
                  // Handle resend OTP
                },
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: Color(0xFF9F86C0),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Verify button
              SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB09FCA), // lighter purple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "VERIFY",
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
