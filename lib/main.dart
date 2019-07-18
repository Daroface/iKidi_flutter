import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'iKidi - Logowanie';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final loginButton = GlobalKey<FormState>();
  TextEditingController loginController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: loginButton,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: loginController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Wprowadź login';
                }
              },
              decoration: InputDecoration(hintText: "Login"),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Wprowadź hasło';
                }
              },
              decoration: InputDecoration(hintText: "Hasło"),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    'Zaloguj',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        textBaseline: TextBaseline.alphabetic),
                  ),
                  onPressed: () {
                    if (loginButton.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Logowanie...')));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
