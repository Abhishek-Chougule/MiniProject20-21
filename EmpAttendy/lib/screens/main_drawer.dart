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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://st4.depositphotos.com/4177785/41130/v/1600/depositphotos_411301348-stock-illustration-employee-attendance-concept-icon-simple.jpg',
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
