import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:i_kidi/Constats.dart';
import 'package:i_kidi/Session.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Padding _spaceUnderLogo = new Padding(
      padding: const EdgeInsets.only(top: Constants.SPACE_UNDER_LOGO_PADDING));

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  height: (screenHeight / 5),
                  child: DrawerHeader(
                      child: Text(
                        'Username',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.fromLTRB(
                          20, (screenHeight / 5 - 80.0), 0, 0))),
              ListTile(
                title: Text('Wyloguj'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
                Constants.SIDE_PADDING,
                Constants.TOP_PADDING,
                Constants.SIDE_PADDING,
                Constants.BOTTOM_PADDING),
            child: Container(
                height: screenHeight - 110.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('image/ikidiLogo.png',
                          width: 184, height: 45, fit: BoxFit.cover),
                      _spaceUnderLogo
                    ]))));
  }
}
