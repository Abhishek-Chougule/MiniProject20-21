import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, ThemeData, Widget, runApp;

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}
