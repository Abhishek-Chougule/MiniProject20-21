import 'package:EmpAttendy/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'emp_login.dart';

class SignUp extends StatelessWidget {
  final String title = "Emp Attendy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: 'Roboto')),
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SignInButton(
                      Buttons.Email,
                      text: "Admin Login",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminLogIn()),
                        );
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SignInButton(
                      Buttons.Email,
                      text: "Employee Login",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmailLogIn()),
                        );
                      },
                    )),
              ]),
        ));
  }
}
