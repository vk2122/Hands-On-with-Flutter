import 'package:flutter/material.dart';
import 'package:spend_wise/widgets/custom_navigation_bar.dart';

import '../widgets/custom_drawer.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<Widget> _buildScreen() {
    return [];
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
      drawer: drawer(context, width),
      bottomNavigationBar: navBar(context),
    );
  }
}
