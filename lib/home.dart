import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:i_kidi/Constats.dart';
import 'package:i_kidi/login_home.dart';
import 'package:i_kidi/server_connection.dart';

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
    return new Scaffold(
        drawer: Builder( builder: (context) => Drawer(
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
                onTap: () async {
                  ServerConnection session = new ServerConnection();
                  var resp = await session.logout(
                      Constants.HOST_URL + Constants.LOGOUT_URL, "");
                  if (resp.compareTo("Successful logout") == 0) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text("Wylogowano")));
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => LoginForm()),
                        );
                      });
                    });
                  }
                },
              ),
            ],
          ),
        )),
        body: Builder(builder: (context) => SingleChildScrollView(
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
                      _spaceUnderLogo,
                      RaisedButton(

                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Test")));
                        },
                      )

                    ])))));
  }
}
