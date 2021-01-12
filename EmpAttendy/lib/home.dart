import 'dart:async';
import 'package:EmpAttendy/screens/wificonnectivity.dart';
import 'package:flutter/material.dart';
import 'package:EmpAttendy/screens/drawer.dart';
import 'package:wifi/wifi.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level = 0;
  String _ip = 'Checking Wifi ...';
  List<WifiResult> ssidList = [];
  String ssid = '', password = '';
  Timer timer;

  Future<void> _markattendance() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WifiConnectivity(uid: widget.uid)),
    );
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => reFresh());
    _getIP();
    super.initState();
    loadData();
  }

  void reFresh() {
    setState(() {
      _getIP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text((() {
              if ('$_ip' == '192.168.43.90') {
                return 'Connected to Company Wifi';
              } else {
                return 'To Mark the Attendance you need to Connect your mobile to the Company Wifi';
              }
            })()),
            Text(""),
            Text(""),
            Text(""),
            Text(""),
            Text(""),
            Text(""),
            FlatButton.icon(
              icon: Icon(Icons.assignment_ind_outlined),
              label: Text("Mark Attendance"),
              splashColor: Colors.blue,
              onPressed: '$_ip' == '192.168.43.90' ? _markattendance : null,
            ),
          ],
        ),
      ),
      drawer: NavigateDrawer(uid: this.widget.uid),
    );
  }

  void loadData() async {
    Wifi.list('').then((list) {
      setState(() {
        ssidList = list;
      });
    });
  }

  Future<Null> _getIP() async {
    String ip = await Wifi.ip;
    setState(() {
      _ip = ip;
    });
  }
}
