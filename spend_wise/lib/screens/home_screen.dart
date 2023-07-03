import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController(initialPage: 2);
  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const screen3(),
    const screen2(),
    const screen1(),
    const screen2(),
    const screen3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? navigationBar(_pageController)
          : null,
    );
  }
}
