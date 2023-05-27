import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String location = "";
  String weather = "";
  bool isLoading = false;

  void fetchWeatherData(String location) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=4ad54bdd85cb54d2733a6a36b1352c6d'));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        weather = data['weather'][0]['main'];
      });
    } else {
      final snackBar = SnackBar(
        content: Text('Failed to fetch weather data'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData("current location");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlue],
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            location = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        fetchWeatherData(location);
                      },
                      icon: Icon(Icons.search),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.width / 2.9,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Weather Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Location: $location',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Weather: $weather',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchWeatherData(location);
        },
        child: isLoading ? CircularProgressIndicator() : Icon(Icons.refresh),
      ),
    );
  }
}
