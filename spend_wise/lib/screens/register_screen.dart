import 'package:flutter/material.dart';
import 'package:spend_wise/widgets/custom_input_field.dart';

import '../models/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<void> registerUser() async {
    try {
      await _authService.registerUser(
        nameController.text,
        emailController.text,
        phoneNumberController.text,
        passwordController.text,
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text(
              'An error occurred during user registration. Please try again.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Register Screen'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            nameInput(width, nameController),
            emailInput(width, emailController),
            phoneInput(width, phoneNumberController),
            passwordInput(width, passwordController),
            SizedBox(height: width * 0.05),
            ElevatedButton(
              onPressed: registerUser,
              child: Text("Register"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: Text(
                "Already have an Account?",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
