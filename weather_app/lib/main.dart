import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/loading.dart';
import 'screens/location.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/" : (context) => LoadingPage(),
      "/home" : (context) => HomePage(),
      "/loading" : (context) => LoadingPage(),
      "/location" : (context) => LocationPage(),

    },
  ));
}

