import 'package:flutter/material.dart';

Widget emailInput(width, controller) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.all(5),
      width: width * 0.9,
      height: width * 0.15,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: width * 0.005,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: 'Enter your email',
          hintStyle: TextStyle(color: Colors.grey, fontSize: width * 0.043),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          if (!emailRegex.hasMatch(value)) {
            // Handle invalid email format
          } else {
            // Valid email format
          }
        },
      ),
    ),
  );
}

Widget passwordInput(width, controller) {
  final passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~]).{8,}$');
  bool _obscureText = true;

  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.all(5),
      width: width * 0.9,
      height: width * 0.15,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: width * 0.005,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: width * 0.043,
              ),
            ),
            onChanged: (value) {
              if (!passwordRegex.hasMatch(value)) {
                // Handle invalid password format
              } else {
                // Valid password format
              }
            },
          ),
          /*IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),*/
        ],
      ),
    ),
  );
}
