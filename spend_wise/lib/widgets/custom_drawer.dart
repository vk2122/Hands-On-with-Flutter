import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget drawer(BuildContext context, double width, values) {
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  return Drawer(
    width: width * 0.7,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: width * 0.35,
          height: width * 0.35,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              print('camera clicked');
            },
          ),
        ),
        Text(
          values.toString(),
        ),
        TextButton.icon(
            onPressed: _logout,
            icon: Icon(Icons.logout_rounded),
            label: Text('Log Out'))
      ],
    ),
  );
}
