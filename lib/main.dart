import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => Landing(),
        "/home": (_) => Home(),
      },
    );
  }
}
