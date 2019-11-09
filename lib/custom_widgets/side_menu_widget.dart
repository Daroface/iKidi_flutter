import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_kidi/server_connection.dart';
import 'package:i_kidi/login_home.dart';

class SideMenu extends StatelessWidget {
  SideMenu({this.username, this.session, this.screenHeight});

  final String username;
  final ServerConnection session;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                height: (screenHeight / 5),
                child: DrawerHeader(
                    child: Text(
                      username,
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
                var resp = await session.logout();
                if (resp.compareTo("Successful logout") == 0) {
                  Future.delayed(const Duration(seconds: 1), () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text("Wylogowano")));
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => LoginForm()),
                    );
                  });
                }
              },
            ),
          ],
        ));
  }
}