// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  var author;
  var quote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todays();
  }

  Future<void> todays() async {
    final url = Uri.parse('https://zenquotes.io/api/today');
    final response = await http.get(url);
    final data = json.decode(response.body);
    setState(() {
      author = data[0]['a'];
      quote = data[0]['q'];
    });
  }

  Future<void> refresh() async {
    final url = Uri.parse('https://zenquotes.io/api/random');
    final response = await http.get(url);
    final data = json.decode(response.body);
    setState(() {
      author = data[0]['a'];
      quote = data[0]['q'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: quote != null
            ? Container(
                padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '"$quote"',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 15),
                    Text(
                      '-- $author',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Refresh Quote',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
