import 'package:flutter/material.dart';

import 'package:style/services/photography.dart';

class Service extends StatefulWidget {
  List<Widget> widgets;
  Service({@required this.widgets});

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Positioned(
          top: width * 0.05,
          right: width * 0.05,
          child: IconButton(
            onPressed: () => print("Close"),
            icon: Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}
