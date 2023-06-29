import 'package:flutter/material.dart';
import 'package:spend_wise/widgets/custom_input_field.dart';

import '../models/firebase_auth.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Login Screen'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          emailInput(width, emailController),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              passwordInput(width, passwordController),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/forgotPass");
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              bool authenticated = await signInWithEmailAndPassword(
                  emailController.text, passwordController.text, context);
              if (authenticated) {
                Navigator.pushReplacementNamed(context, "/home");
              }
            },
            child: const Text('Log In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/register");
            },
            child: Text(
              "Don't have an Account?",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
