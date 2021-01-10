import 'dart:async';
import 'package:EmpAttendy/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WifiConnectivity(),
    );
  }
}

class WifiConnectivity extends StatefulWidget {
  WifiConnectivity({this.uid});
  final String uid;
  @override
  _WifiConnectivityState createState() => _WifiConnectivityState();
}

class _WifiConnectivityState extends State<WifiConnectivity> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String wifiname;
  String status = 'No Connected !';
  String connectionStatus;

  DateTime gettime = DateTime.now();
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => reFresh());
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectionStatus = result.toString());
    });
  }

  void reFresh() {
    setState(() {
      gettime = DateTime.now();
      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        _connectionStatus = result.toString();
      });
      wifiname = 'Connection Status: $_connectionStatus';
      if (wifiname == 'Connection Status: ConnectivityResult.wifi') {
        status = 'Connected';
      } else {
        status = 'No Connected !';
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
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }

    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wifi Connectivity"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(status),
              Text('\n' + gettime.toString()),
            ],
          ),
        ),
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}
