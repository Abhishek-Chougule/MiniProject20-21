import 'package:EmpAttendy/screens/signup.dart';
import 'package:EmpAttendy/screens/wificonnectivity.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://www.zohowebstatic.com/sites/default/files/attendance-biometric.png',
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    'Attendy',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'admin@empattendy.in',
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
            onTap: null,
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
