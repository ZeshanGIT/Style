import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'services/photography.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nexa"),
      routes: {
        "/": (_) => Home(),
        "/${Strings.photography}": (_) => Photography(),
      },
    );
  }
}
