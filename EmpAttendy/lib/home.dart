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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String cuid = 'null';
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Attendance");
  DatabaseReference dbRef1 =
      FirebaseDatabase.instance.reference().child("StopAttendance");

  Future<void> _markattendance() async {
    registerToFb();
  }

  Future<void> _stopattendance() async {
    registerToFb1();
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
            Image(
                width: 100,
                height: 100,
                image: AssetImage('assets/profile.png')),
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
              onPressed: '$_ip' == '192.168.43.90' && '$cuid' != widget.uid
                  ? _markattendance
                  : null,
            ),
            FlatButton.icon(
              icon: Icon(Icons.assignment_ind_outlined),
              label: Text("Stop Attendance"),
              splashColor: Colors.blue,
              onPressed: '$_ip' == '192.168.43.90' && '$cuid' == widget.uid
                  ? _stopattendance
                  : null,
            ),
          ],
        ),
      ),
      drawer: NavigateDrawer(uid: this.widget.uid),
    );
  }

  void registerToFb() {
    dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        cuid = values["uid"];
        dbRef.child(values["uid"]).set({
          "uid": widget.uid,
          "status": 'present',
          "datetime": (DateTime.now()).toString()
        });
      });
    });

    //dbRef.orderByChild("uid").equalTo(widget.uid).once();
  }

  void registerToFb1() {
    dbRef1.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        cuid = 'null';
        dbRef1
            .child(values["uid"])
            .set({"uid": widget.uid, "datetime": (DateTime.now()).toString()});
      });
    });

    //dbRef.orderByChild("uid").equalTo(widget.uid).once();
  }

  Future<Null> _getIP() async {
    String ip = await Wifi.ip;
    setState(() {
      _ip = ip;
    });
  }
}
