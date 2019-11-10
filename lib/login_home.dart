import 'package:flutter/material.dart';
import 'package:i_kidi/constants.dart';
import 'package:i_kidi/server_connection.dart';
import 'package:i_kidi/home.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginButton = GlobalKey<FormState>();
  ServerConnection session = new ServerConnection();
  TextEditingController _loginController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final Padding _space =
      new Padding(padding: const EdgeInsets.only(top: Constants.SPACE_PADDING));
  final Padding _spaceUnderLogo = new Padding(
      padding: const EdgeInsets.only(top: Constants.SPACE_UNDER_LOGO_PADDING));

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: Builder(
            builder: (context) => SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    Constants.SIDE_PADDING,
                    Constants.TOP_PADDING,
                    Constants.SIDE_PADDING,
                    Constants.BOTTOM_PADDING),
                child: Container(
                    height: screenHeight - 110.0,
                    child: Form(
                        key: _loginButton,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset('image/ikidiLogo.png',
                                  width: 184, height: 45, fit: BoxFit.cover),
                              _spaceUnderLogo,
                              TextFormField(
                                  controller: _loginController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return Constants.LOGIN_ERROR_STATEMENT;
                                    }else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: Constants.LOGIN_FIELD_HINT,
                                      border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      )))),
                              _space,
                              TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return Constants.PASSWORD_ERROR_STATEMENT;
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: Constants.PASSWORD_FIELD_HINT,
                                      border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      )))),
                              _space,
                              ButtonTheme(
                                  minWidth: screenWidth,
                                  child: RaisedButton(
                                      color: Colors.blueGrey,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      // textColor: Colors.white,
                                      child: Text(Constants.LOGIN_BUTTON_TEXT,
                                          style: TextStyle(
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              textBaseline:
                                                  TextBaseline.alphabetic)),
                                      onPressed: () {
                                        connect(context);
                                      }))
                            ]))))));
  }

  void connect(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_loginButton.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(Constants.LOGGING_STATEMENT)));
      var body = {
        Constants.LOGIN_PARAMETER: _loginController.text,
        Constants.PASSWORD_PARAMETER: _passwordController.text
      };
      String resp = "";
      resp =
          await session.login(body);
      if (resp.compareTo("Successful") == 0) {
        Scaffold.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2), content: Text("Zalogowano")));
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) => HomeScreen(session: session)),
            );
          });
        });
      } else if (resp.compareTo("Invalid login attempt") == 0) {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(Constants.ERROR_SIGNIN_MESSAGE)));
      }
    }
  }
}
