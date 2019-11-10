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
  final String clubName;

  ClubScreen({this.session, this.id, this.username, this.clubName});

  @override
  ClubScreenState createState() => ClubScreenState(session: session, id: id, username: username, clubName: clubName);
}

class ClubScreenState extends State<ClubScreen> {
  ServerConnection session;
  String username = "";
  Map<String, dynamic> clubData = new Map();
  String clubName;
  String id;

  ClubScreenState({this.session, this.id, this.username, this.clubName});

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> clubDataTmp;
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
    List<dynamic> items = new List();
    if(clubData.length > 0)
      items = clubData['Sections'];

    if (clubData.length > 0 && items.length > 0)
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
                      width: screenWidth,
//                      decoration: BoxDecoration(
//                          border: Border.all(),
//                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            LogoWidget(),
                            Text(clubName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,)),
                            showClubInformation(screenWidth)
                          ])))));
    else
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
                            LogoWidget(),
                            Text(clubName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,))
                          ])))));
  }

  Future<String> getClubInformation(ServerConnection session, String id) async {
    var resp = await session.club(id);
    return resp;
  }

  Container showClubInformation(double screenWidth) {
    List<Widget> mainList = new List();
    mainList.add(Constants.spaceUnderLogo);
    for (int i = 0; i < clubData.length; i++) {
      List<Widget> list = new List();
      list.add(new Text(clubData['Sections'][0]['Items'][i]['Title'],
          style: new TextStyle(decoration: TextDecoration.underline, fontSize: 22.0)));
      list.add(Constants.spaceUnderSubelement);
      list.add(new Text(clubData['Sections'][0]['Items'][i]['Description'],
          style: new TextStyle(fontSize: 16.0)));

      Column column = new Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: list);

      Container container = new Container(child: column, width: screenWidth);

      mainList.add(container);
      mainList.add(Constants.spaceUnderElement);
    }
    Column mainColumn = new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: mainList);
    Container mainContainer = new Container(child: mainColumn);

    return mainContainer;
  }

}
