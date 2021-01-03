import 'package:EmpAttendy/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: About(),
    );
  }
}

class About extends StatefulWidget {
  About({this.uid});
  final String uid;
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Center(),
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}
