import 'package:flutter/material.dart';
import 'package:i_kidi/constants.dart';
import 'package:i_kidi/custom_widgets/side_menu_widget.dart';
import 'package:i_kidi/custom_widgets/logo_widget.dart';
import 'package:i_kidi/server_connection.dart';
import 'dart:convert';

class ClubScreen extends StatefulWidget {
  final ServerConnection session;
  final String id;
  final String username;

  ClubScreen({this.session, this.id, this.username});

  @override
  ClubScreenState createState() => ClubScreenState(session: session, id: id, username: username);
}

class ClubScreenState extends State<ClubScreen> {
  ServerConnection session;
  String username = "";
  List<dynamic> clubData = new List();
  String id;

  ClubScreenState({this.session, this.id, this.username});

  @override
  void initState() {
    super.initState();
    List<dynamic> clubDataTmp;
    getClubInformation(this.session, this.id).then((resp) {
      try {
        print(resp);
        clubDataTmp = jsonDecode(resp);
        clubData = clubDataTmp;
      } catch (ex) {
        print('Custom Error #2: ');
        print(ex);
      }
      setState(() {
        clubData = clubDataTmp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width - 2 * Constants.SIDE_PADDING;

      return new Scaffold(
          drawer: Builder(
              builder: (context) => SideMenuWidget(
                  username: username,
                  session: session,
                  screenHeight: screenHeight)),
          body: Builder(
              builder: (context) => SingleChildScrollView(
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
                            LogoWidget()
                          ])))));
  }

  Future<String> getClubInformation(ServerConnection session, String id) async {
    var resp = await session.club(id);
    return resp;
  }
}
