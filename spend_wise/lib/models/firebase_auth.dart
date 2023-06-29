import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<bool> signInWithEmailAndPassword(
  String email,
  String password,
  BuildContext context,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // Authentication successful
    return true;
  } catch (e) {
    // Handle authentication errors
    String errorMessage = 'An error occurred during authentication.';
    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = 'Invalid email or password.';
        // Show the Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
    // Authentication failed
    return false;
  }
}

class FirebaseAuthService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> registerUser(
    String name,
    String email,
    String phoneNumber,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details in Firebase Realtime Database
      String userId = userCredential.user!.uid;
      _database.child('users').child(userId).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      });

      print('User registered successfully: ${userCredential.user?.email}');
    } catch (e) {
      print('Error during user registration: $e');
      throw e; // Throw the error for the calling code to handle
    }
  }
}

Future<void> sendPasswordResetEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // Password reset email sent successfully
  } catch (e) {
    // Error occurred while sending password reset email
    throw e;
  }
}
