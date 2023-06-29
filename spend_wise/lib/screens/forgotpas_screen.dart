import 'package:flutter/material.dart';

class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Forgot Password Screen'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Back')),
    );
  }
}
