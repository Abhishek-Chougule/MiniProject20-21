import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:imei_plugin/imei_plugin.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNetwork(),
    );
  }
}

class MyNetwork extends StatefulWidget {
  @override
  _MyNetworkState createState() => _MyNetworkState();
}

class _MyNetworkState extends State<MyNetwork> {
  String _macAddress = "Unknown";
  String _imeiNumber = "Unknown";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String macAddress;
    String imeiNumber;

    try {
      macAddress = await GetMac.macAddress;
      imeiNumber =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    } on PlatformException {
      macAddress = "Faild to get Device MAC Adress";
    }
    if (!mounted) return;

    setState(() {
      _macAddress = macAddress;
      _imeiNumber = imeiNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get MAC, IMEI"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("MAC Address :  " + _macAddress),
              Text(''),
              Text("IMEI Number :  " + _imeiNumber),
            ],
          ),
        ));
  }
}
