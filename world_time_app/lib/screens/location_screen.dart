import 'package:flutter/material.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({
    required this.location,
    required this.time,
    required this.flag,
    required this.url,
    required this.isDaytime,
  });
}

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(
        location: 'London',
        time: '',
        flag: 'uk.png',
        url: 'Europe/London',
        isDaytime: true),
    WorldTime(
        location: 'Athens',
        time: '',
        flag: 'greece.png',
        url: 'Europe/Berlin',
        isDaytime: true),
    WorldTime(
        location: 'Cairo',
        time: '',
        flag: 'egypt.png',
        url: 'Africa/Cairo',
        isDaytime: true),
    WorldTime(
        location: 'Kolkata',
        time: '',
        flag: 'usai.png',
        url: 'Asia/Kolkata',
        isDaytime: true),
    WorldTime(
        location: 'Chicago',
        time: '',
        flag: 'usa.png',
        url: 'America/Chicago',
        isDaytime: true),
    WorldTime(
        location: 'New York',
        time: '',
        flag: 'usa.png',
        url: 'America/New_York',
        isDaytime: true),
    WorldTime(
        location: 'Seoul',
        time: '',
        flag: 'south_korea.png',
        url: 'Asia/Seoul',
        isDaytime: true),
    WorldTime(
        location: 'Jakarta',
        time: '',
        flag: 'indonesia.png',
        url: 'Asia/Jakarta',
        isDaytime: true),
  ];

  Future<void> updateTime(int index) async {
    WorldTime instance = locations[index];
    // Perform your API call or time-related operations here to update instance.time
    // For brevity, I'm not including the actual API call or time calculation code
    instance.time =
        DateTime.now().toString(); // Placeholder code to set the time

    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose a Location'),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
