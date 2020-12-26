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
                    width: 100,
                    height: 100,
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
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text(
              'Attendy Report',
              style: TextStyle(fontSize: 16),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
