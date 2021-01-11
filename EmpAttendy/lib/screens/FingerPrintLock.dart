import 'package:EmpAttendy/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/lock_screen.dart';
import 'dart:async';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthApp(),
    );
  }
}

class AuthApp extends StatefulWidget {
  AuthApp({this.uid});
  final String uid;

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;
  String authorized = "Not authorized";
  bool authenticated = false;
  String pin = '1234';

  Future<void> _checkBiometric() async {
    bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  //this function will get all the available biometrics inside our device
  //it will return a list of objects, but for our example it will only
  //return the fingerprint biometric
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometric;
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your finger print for Attendance",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      authorized =
          authenticated ? "Autherized success" : "Failed to authenticate";
    });
  }

  @override
  void initState() {
    _authenticate();
    super.initState();
    _checkBiometric();
    _getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            '$_availableBiometric' == '[BiometricType.fingerprint]'
                ? Center(
                    child: FlatButton.icon(
                      icon: '$authorized' == 'Autherized success'
                          ? Icon(Icons.assignment_ind_outlined)
                          : Icon(Icons.fingerprint),
                      label: '$authorized' == 'Autherized success'
                          ? Text("")
                          : Text("Authenticate"),
                      splashColor: Colors.blue,
                      onPressed: '$authorized' == 'Autherized success'
                          ? null
                          : _authenticate,
                    ),
                  )
                : Center(),
            Text(""),
            Text(""),
            '$_availableBiometric' == '[BiometricType.fingerprint]'
                ? Text((() {
                    if ('$authorized' == 'Autherized success') {
                      return 'Authenticated Successfull !' +
                          "\n\n" +
                          'Now Click on Verify Button';
                    } else {
                      return 'Can check biometric: $_canCheckBiometric' +
                          '\n\n' +
                          'Available biometric: $_availableBiometric' +
                          '\n\n' +
                          'Current State: $authorized!';
                    }
                  })())
                : Text((() {
                    if ('$authorized' == 'Autherized success') {
                      return '' + "\n\n" + '';
                    } else {
                      return '' +
                          '\n\n' +
                          'Fingerprint Sensor not Available try Pin Lock' +
                          '\n\n' +
                          '';
                    }
                  })()),
            Text(""),
            Text(""),
            '$_availableBiometric' == '[BiometricType.fingerprint]'
                ? Center(
                    child: FlatButton.icon(
                      icon: const Icon(Icons.verified),
                      label: const Text("Verify Fingerprint"),
                      splashColor: '$authorized' == 'Autherized success'
                          ? Colors.green
                          : Colors.red,
                      onPressed: () {
                        if ('$authorized' == 'Autherized success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(uid: widget.uid)),
                          );
                        }
                      },
                    ),
                  )
                : Center(),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Text(''),
            Center(
              child: FlatButton.icon(
                icon: const Icon(Icons.lock),
                label: const Text("Pin Lock"),
                splashColor: '$authorized' == 'Autherized success'
                    ? Colors.green
                    : Colors.red,
                onPressed: () => '$pin' == '1234'
                    ? showConfirmPasscode(
                        context: context,
                        onCompleted: (context, verifyCode) {
                          pin = verifyCode;
                          Navigator.of(context).maybePop();
                        },
                      )
                    : showLockScreen(
                        context: context,
                        correctString: pin,
                        canCancel: false,
                        onUnlocked: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(uid: widget.uid)),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
