import 'dart:async';
import 'package:EmpAttendy/home.dart';
import 'package:connectivity/connectivity.dart';
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
  MyNetwork({this.uid});
  final String uid;
  @override
  _MyNetworkState createState() => _MyNetworkState();
}

class _MyNetworkState extends State<MyNetwork> {
  String _macAddress = "Unknown";
  String _imeiNumber = "Unknown";
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String wifiname;
  String status = 'No Connected !';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectionStatus = result.toString());
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<Null> initConnectivity() async {
    String connectionStatus;

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
      wifiname = 'Connection Status: $_connectionStatus';
      if (wifiname == 'Connection Status: ConnectivityResult.wifi') {
        status = 'Connected';
      }
    });
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
          title: Text("My Network"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text((() {
                if (status == 'Connected') {
                  return 'MAC Address :  $_macAddress' +
                      "\n\n" +
                      'IMEI Number :   $_imeiNumber';
                } else {
                  return 'No Active Users !';
                }
              })()),
            ],
          ),
        ),
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}
