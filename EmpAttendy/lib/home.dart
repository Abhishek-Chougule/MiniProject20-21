import 'package:EmpAttendy/screens/mynetwork.dart';
import 'package:EmpAttendy/screens/wificonnectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "Home";

  Color color = Colors.white;
  String disp = 'Welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
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
        body: Center(child: Text(disp)),
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
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}

class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key key, this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['email']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            accountName: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['name']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home_outlined),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.network_check),
              onPressed: () => null,
            ),
            title: Text('Connectivity'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WifiConnectivity()),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.network_cell),
              onPressed: () => null,
            ),
            title: Text('Network'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyNetwork()),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.settings_outlined),
              onPressed: () => null,
            ),
            title: Text('Settings'),
            onTap: () {
              print(widget.uid);
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.add_box_outlined),
              onPressed: () => null,
            ),
            title: Text('About'),
            onTap: () {
              print(widget.uid);
            },
          ),
        ],
      ),
    );
  }
}
