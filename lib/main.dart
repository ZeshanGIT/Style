import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'services/photography.dart';
import 'pages/landing.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nexa"),
      routes: {
        "/": (_) => Landing(),
        "/home": (_) => Home(),
        "/${Strings.photography}": (_) => Photography(),
      },
    );
  }
}
