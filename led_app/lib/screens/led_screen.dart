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
    databaseReference = FirebaseDatabase.instance.ref();

    // Listen for changes in the bulb state from the database
    databaseReference.child('bulbstate/isOn').onValue.listen((event) {
      bool? bulbState = event.snapshot.value as bool?;
      setState(() {
        _bulbState = bulbState ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Node Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _bulbState
                ? Image.asset('assets/light-on.png')
                : Image.asset('assets/light-off.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final snackBar = _bulbState
                        ? SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'Status of Bulb : ${_bulbState.toString()}'),
                          )
                        : SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'Status of Bulb : ${_bulbState.toString()}'),
                          );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text("Status"),
                ),
                ElevatedButton(
                  onPressed: () {
                    bool newState = !_bulbState;
                    updateBulbState(newState);
                    setState(() {
                      _bulbState = newState;
                    });
                  },
                  child: const Text("On/Off"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateBulbState(bool state) {
    databaseReference.child('bulbstate/isOn').set(state);
  }
}
