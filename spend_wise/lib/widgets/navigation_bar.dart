
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

Widget navigationBar(_pageController) {
  final _controller = NotchBottomBarController(index: 2);

  return AnimatedNotchBottomBar(
    notchBottomBarController: _controller,
    color: Colors.black54,
    showBlurBottomBar: true,
    blurOpacity: 0.2,
    blurFilterX: 5.0,
    blurFilterY: 10.0,
    showLabel: false,
    notchColor: Colors.black87,
    removeMargins: false,
    bottomBarWidth: 500,
    durationInMilliSeconds: 300,
    bottomBarItems: const [
      BottomBarItem(
        inActiveItem: Icon(
          Icons.menu_book_outlined,
          color: Colors.grey,
        ),
        activeItem: Icon(
          Icons.menu_book_sharp,
          color: Colors.white,
        ),
        itemLabel: 'Page 1',
      ),
      BottomBarItem(
        inActiveItem: Icon(
          Icons.pie_chart_outline_outlined,
          color: Colors.grey,
        ),
        activeItem: Icon(
          Icons.pie_chart_outline_sharp,
          color: Colors.white,
        ),
        itemLabel: 'Page 2',
      ),
      BottomBarItem(
        inActiveItem: Icon(
          Icons.add_outlined,
          color: Colors.grey,
        ),
        activeItem: Icon(
          Icons.add_sharp,
          color: Colors.white,
        ),
        itemLabel: 'Page 3',
      ),
      BottomBarItem(
        inActiveItem: Icon(
          Icons.attach_money_outlined,
          color: Colors.grey,
        ),
        activeItem: Icon(
          Icons.attach_money_sharp,
          color: Colors.white,
        ),
        itemLabel: 'Budget',
      ),
      BottomBarItem(
        inActiveItem: Icon(
          Icons.person_outline_outlined,
          color: Colors.grey,
        ),
        activeItem: Icon(
          Icons.person_outline_sharp,
          color: Colors.white,
        ),
        itemLabel: 'Profile',
      ),
    ],
    onTap: (index) {
      _pageController.jumpToPage(index);
    },
  );
}
