import 'package:flutter/material.dart';
import './screens/main_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

Color color = Colors.white;
String disp = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emp Attendy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Emp Attendy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
        items: [
          Icon(Icons.home_outlined),
          Icon(Icons.person_outlined),
          Icon(Icons.speaker_phone),
          Icon(Icons.settings_outlined),
        ],
        onTap: (index) {
          setState(() {
            if (index == 0) {
              color = Colors.white;
              disp = 'Home';
            } else if (index == 1) {
              color = Colors.white;
              disp = 'Profile';
            } else if (index == 2) {
              color = Colors.white;
              disp = 'My Network';
            } else if (index == 3) {
              color = Colors.white;
              disp = 'Settings';
            }
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              disp,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
