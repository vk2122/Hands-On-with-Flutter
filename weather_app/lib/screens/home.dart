import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "Vapi";
  String desc = "description";
  String windspeed = "0.0";
  String temperature = "00.0";
  String humidity = "0.0";
  String icon = "02d";

  var searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fetchedMap =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(fetchedMap);

    name = fetchedMap['keyName'];
    desc = fetchedMap['keyDesc'];
    humidity = fetchedMap['keyHumidity'];
    icon = fetchedMap['keyIcon'];
    temperature = fetchedMap['keyTemp'];
    windspeed = fetchedMap['keyWindspeed'];

    if (windspeed == "NA" && temperature == "NA") {
    } else {
      windspeed = windspeed.toString().substring(0,
          windspeed.toString().length >= 4 ? 4 : windspeed.toString().length);
      temperature = temperature.toString().substring(
          0,
          temperature.toString().length >= 4
              ? 4
              : temperature.toString().length);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Color(0xff424d5d),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xffc3c8cb),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchCtrl,
                          decoration: InputDecoration(
                            hintText: "Search any city name....",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: InkWell(
                            onTap: () {
                              if (searchCtrl.text.replaceAll(" ", "") != "") {
                                Navigator.pushReplacementNamed(
                                    context, '/loading', arguments: {
                                  "searchData": searchCtrl.text.toString()
                                });
                              }
                            },
                            child: Icon(Icons.search)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "$name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                      color: Color(0xffc3c8cb),
                      fontSize: 24),
                ),
                Text(
                  "TODAY",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Jost',
                      color: Color(0xffc3c8cb),
                      fontSize: 12),
                ),
                SizedBox(height: 40),
                Image.network(
                  "https://openweathermap.org/img/wn/$icon@2x.png",
                  height: 100,
                  width: 100,
                ),
                Text(
                  "$desc",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Jost',
                      color: Color(0xffc3c8cb),
                      fontSize: 18),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Temperature",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Jost',
                              color: Color(0xffc3c8cb),
                              fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$temperature°C",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jost',
                              color: Color(0xffc3c8cb),
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Wind Speed",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Jost',
                              color: Color(0xffc3c8cb),
                              fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$windspeed km/h",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jost',
                              color: Color(0xffc3c8cb),
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Humidity",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Jost',
                              color: Color(0xffc3c8cb),
                              fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$humidity%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jost',
                              color: Color(0xffc3c8cb),
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
