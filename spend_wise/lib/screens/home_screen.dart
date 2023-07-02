import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  Object? values = [];
  void _readPersonalData() {
    databaseReference.child('users').onValue.listen((event) {
      setState(() {
        values = event.snapshot.value;
      });
      print(values);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      drawer: drawer(context, width, values),
      //bottomNavigationBar: navBar(context),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _readPersonalData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
