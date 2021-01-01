import 'package:EmpAttendy/screens/mynetwork.dart';
import 'package:EmpAttendy/screens/signup.dart';
import 'package:EmpAttendy/screens/wificonnectivity.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20, top: 20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 70,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  Column(
                    children: <Widget>[
                      Container(//space for future add)
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt_long_rounded),
            title: Text(
              'Attendy Report',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WifiConnectivity()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_rounded),
            title: Text(
              'Support',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyNetwork()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Setting',
              style: TextStyle(fontSize: 16),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 16),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
