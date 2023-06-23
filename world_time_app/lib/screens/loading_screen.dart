import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String location;
  String flag;
  String url;
  late bool isDaytime;
  late String time;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        String datetime = data['datetime'];
        int offset = int.parse(data['utc_offset'].substring(1, 3));

        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: offset));

        isDaytime = now.hour > 6 && now.hour < 20;
        time = now.toString();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setWorldTime() async {
    WorldTime instance = WorldTime(
      location: 'Kolkata',
      flag: 'usai.png',
      url: 'Asia/Kolkata',
    );
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDaytime,
    });
  }

  @override
  void initState() {
    setWorldTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}
