import 'dart:async';
import 'package:EmpAttendy/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  String status = 'Not Connected !';
  String connectionStatus;

  DateTime now = DateTime.now();
  String formattedDate = '0';
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => reFresh());
    initConnectivity();
  }

  void reFresh() {
    setState(() {
      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        setState(() => _connectionStatus = result.toString());
        var start, end;
        '$status' == 'Connected'
            ? start = new DateTime.now()
            : end = new DateTime.now();
        '$status' != 'Connected'
            ? start = new DateTime(2021, DateTime.january, 31)
            : end = DateTime(2000, DateTime.september, 16);
        Duration difference = end.difference(start);
        print(difference.inDays);
      });
      now = DateTime.now();
      formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
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
    var start;
    '$status' == 'Connected'
        ? start = new DateTime.now()
        : start = new DateTime(2000, DateTime.september, 16);
    var end;
    '$status' == 'Connected'
        ? end = new DateTime(2021, DateTime.january, 31)
        : end = DateTime(2000, DateTime.september, 16);
    Duration difference = end.difference(start);
    return Scaffold(
        appBar: AppBar(
          title: Text("Wifi Connectivity"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(status),
              Text('\n' + formattedDate),
              Text((difference.inDays).toString()),
              Text((difference.inHours).toString()),
              Text((difference.inMinutes).toString()),
              Text((difference.inMilliseconds).toString()),
            ],
          ),
        ),
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}
