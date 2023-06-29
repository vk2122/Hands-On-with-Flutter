import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _logout,
          child: Text('Logout'),
        ),
      ),
    );
  }
}
