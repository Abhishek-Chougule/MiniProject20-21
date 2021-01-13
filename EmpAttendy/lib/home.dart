import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:EmpAttendy/screens/drawer.dart';
import 'package:wifi/wifi.dart';
import 'firebase_auth/signup.dart';
import 'package:EmpAttendy/firebase_auth/signup.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level = 0;
  String _ip = 'Checking Wifi ...';
  Timer timer;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Attendance");

  Future<void> _markattendance() async {
    registerToFb();
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => reFresh());
    _getIP();
    super.initState();
  }

  void reFresh() {
    setState(() {
      _getIP();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
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
              onPressed:
                  '$_ip' == '192.168.43.90' && _formKey.currentState.validate()
                      ? _markattendance
                      : registerToFb,
            ),
          ],
        ),
      ),
      drawer: NavigateDrawer(uid: this.widget.uid),
    );
  }

  void registerToFb() {
    dbRef.push().set({
      "uid": widget.uid,
      "status": 'present',
      "datetime": (DateTime.now()).toString()
    });
  }

  Future<Null> _getIP() async {
    String ip = await Wifi.ip;
    setState(() {
      _ip = ip;
    });
  }
}
