import 'package:EmpAttendy/screens/mynetwork.dart';
import 'package:EmpAttendy/firebase_auth/signup.dart';
import 'package:EmpAttendy/screens/settings.dart';
import 'package:EmpAttendy/screens/about.dart';
import 'package:EmpAttendy/screens/wificonnectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/chatData.dart';
import 'package:flutter_chat/chatWidget.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "Home";
  @override
  void initState() {
    super.initState();
    ChatData.init("Just Chat", context);
  }

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
        body: Center(
          child: ChatWidget.widgetWelcomeScreen(context),
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
            currentAccountPicture: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(snapshot.data.value['name'][0]),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            accountEmail: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        'Email            :   ' + snapshot.data.value['email']);
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
                    return Text(
                        'Username    :   ' + snapshot.data.value['name']);
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
              onPressed: () {
                print(widget.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(uid: widget.uid)),
                );
              },
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WifiConnectivity(uid: widget.uid)),
                );
              },
            ),
            title: Text('Connectivity'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WifiConnectivity(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.network_cell),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyNetwork(uid: widget.uid)),
                );
              },
            ),
            title: Text('Network'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyNetwork(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Settings(uid: widget.uid)),
                );
              },
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Settings(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.add_box_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => About(uid: widget.uid)),
                );
              },
            ),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About(uid: widget.uid)),
              );
            },
          ),
        ],
      ),
    );
  }
}
