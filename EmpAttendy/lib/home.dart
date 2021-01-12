import 'dart:async';

import 'package:EmpAttendy/firebase_auth/signup.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EmpAttendy/screens/drawer.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:imei_plugin/imei_plugin.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "Home";
  String _macAddress = "Unknown";
  String _imeiNumber = "Unknown";
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String wifiname;
  String status = 'Not Connected !';
  Timer timer;
  String connectionStatus;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => reFresh());
    initPlatformState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectionStatus = result.toString());
    });
  }

  void reFresh() {
    setState(() {
      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        _connectionStatus = result.toString();
      });
      wifiname = 'Connection Status: $_connectionStatus';
      if (wifiname == 'Connection Status: ConnectivityResult.wifi') {
        status = 'Connected';
      } else {
        status = 'Not Connected !';
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    timer?.cancel();
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
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text((() {
                if (status == 'Connected') {
                  return 'MAC Address :  $_macAddress' +
                      "\n\n" +
                      'IMEI Number :   $_imeiNumber';
                } else {
                  return 'No Active Users !' +
                      '\n\n' +
                      'MAC Address :  $_macAddress' +
                      "\n\n" +
                      'IMEI Number :   $_imeiNumber';
                }
              })()),
            ],
          ),
        ),
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}
