import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ESP32App extends StatefulWidget {
  @override
  _ESP32AppState createState() => _ESP32AppState();
}

class _ESP32AppState extends State<ESP32App> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  BluetoothDevice? _selectedDevice;
  TextEditingController _wifiNameController = TextEditingController();
  TextEditingController _wifiPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  void _stopScan() {
    flutterBlue.stopScan();
  }

  void _connectToDevice(BluetoothDevice device) {
    _stopScan();
    setState(() {
      _selectedDevice = device;
    });
  }

  void _sendWiFiCredentials() {
    String wifiName = _wifiNameController.text;
    String wifiPassword = _wifiPasswordController.text;

    // Send the Wi-Fi credentials to the selected ESP32 device
    // You can add your implementation logic here

    // Clear the text fields after sending the credentials
    _wifiNameController.clear();
    _wifiPasswordController.clear();

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Credentials Sent"),
        content: Text("Wi-Fi credentials sent to ${_selectedDevice!.name}"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Device Setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('ESP32 Device Setup'),
        ),
        body: Column(
          children: [
            if (_selectedDevice == null)
              Expanded(
                child: StreamBuilder<List<ScanResult>>(
                  stream: flutterBlue.scanResults,
                  initialData: [],
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        BluetoothDevice device = snapshot.data![index].device;
                        return ListTile(
                          title: Text(device.name),
                          subtitle: Text(device.id.toString()),
                          onTap: () {
                            _connectToDevice(device);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            if (_selectedDevice != null)
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Selected Device: ${_selectedDevice!.name}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _wifiNameController,
                      decoration: InputDecoration(
                        labelText: "Wi-Fi Name",
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _wifiPasswordController,
                      decoration: InputDecoration(
                        labelText: "Wi-Fi Password",
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _sendWiFiCredentials,
                      child: Text("Send Wi-Fi Credentials"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
