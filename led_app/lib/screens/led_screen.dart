import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LedScreen extends StatefulWidget {
  const LedScreen({Key? key}) : super(key: key);

  @override
  _LedScreenState createState() => _LedScreenState();
}

class _LedScreenState extends State<LedScreen> {
  late DatabaseReference databaseReference;
  bool _bulbState = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    databaseReference = FirebaseDatabase.instance.reference();

    // Reading initial value of bulbstate
    databaseReference.child('bulbstate').once().then((DataSnapshot snapshot) {
          bool? bulbState = snapshot.value as bool?;
          setState(() {
            _bulbState = bulbState ?? false;
          });
        } as FutureOr Function(DatabaseEvent value));

    // Listen for changes in the bulb state from the database
    databaseReference.child('bulbstate').onValue.listen((event) {
      bool? bulbState = event.snapshot.value as bool?;
      setState(() {
        _bulbState = bulbState ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _bulbState
            ? Image.asset('assets/light-on.png')
            : Image.asset('assets/light-off.png'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool newState = !_bulbState;
          updateBulbState(newState);
          setState(() {
            _bulbState = newState;
          });
        },
        child: _bulbState ? Icon(Icons.stop) : Icon(Icons.arrow_right_sharp),
      ),
    );
  }

  void updateBulbState(bool state) {
    databaseReference.child('bulbstate').set(state);
  }
}
