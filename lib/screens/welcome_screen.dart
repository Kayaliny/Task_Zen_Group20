import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: 120), // Load logo
            const SizedBox(height: 20),
            const Text(
              "Welcome to TaskZen,\nwhere simplicity meets productivity.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Log In",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ),
              isFilled: true,
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: "Sign Up",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              ),
              isFilled: false,
            ),
          ],
        ),
      ),
    );
  }
}
