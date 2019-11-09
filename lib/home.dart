import 'package:flutter/material.dart';
import 'package:i_kidi/constants.dart';
import 'package:i_kidi/custom_widgets/side_menu_widget.dart';
import 'package:i_kidi/server_connection.dart';
import 'package:i_kidi/club.dart';
import 'package:i_kidi/custom_widgets/logo_widget.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.session});

  final ServerConnection session;

  @override
  HomeScreenState createState() => HomeScreenState(session);
}

class HomeScreenState extends State<HomeScreen> {
  ServerConnection session;
  String username = "";
  List<dynamic> wallData = new List();

  HomeScreenState(ServerConnection session) {
    this.session = session;
  }

  @override
  void initState() {
    super.initState();
    List<dynamic> wallDataTmp;
    getWallContent(this.session).then((resp) {
      try {
        wallDataTmp = jsonDecode(resp);
        wallData = wallDataTmp;
      } catch (ex) {
        print('Custom Error #1: ');
        print(ex);
      }
      setState(() {
        wallData = wallData;
        username = wallData[0]['Username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width - 2 * Constants.SIDE_PADDING;

    if (wallData.length == 0)
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
                      width: screenWidth,
//                      decoration: BoxDecoration(
//                          border: Border.all(),
//                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            LogoWidget(),
                            showWallItems(screenWidth)
                          ])))));
  }

  Container showWallItems(double screenWidth) {
    List<Widget> mainList = new List();

    for (int i = 1; i < wallData.length; i++) {
      List<Widget> list = new List();
      list.add(new Text(wallData[i]['Title'],
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)));
      list.add(Constants.spaceUnderSubelement);
      list.add(new Text(wallData[i]['Description'],
          style: new TextStyle(fontSize: 10.0)));
      list.add(Constants.spaceUnderSubelement);
      list.add(
          new Image.network(Constants.HOST_URL + wallData[i]['ImageUrl']));

      Column column = new Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: list);

      Container container = new Container(child: column, width: screenWidth);

      InkWell iW = new InkWell(child: container, onTap: () {
        openClubScreen(wallData[i]['ProductId'].toString());});

      mainList.add(iW);
      mainList.add(Constants.spaceUnderElement);
    }
    Column mainColumn = new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: mainList);
    Container mainContainer = new Container(child: mainColumn);

    return mainContainer;
  }

  void openClubScreen(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClubScreen(session: session, id: id, username: username)),
    );
  }

  Future<String> getWallContent(ServerConnection session) async {
    var resp = await session.home();
    return resp;
  }
}
