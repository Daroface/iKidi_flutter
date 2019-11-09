import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_kidi/constants.dart';

class LogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('image/ikidiLogo.png',
                width: 184, height: 45, fit: BoxFit.cover),
            Constants.spaceUnderLogo,
          ]
        ));
  }
}