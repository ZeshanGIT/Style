import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style/utilities/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Landing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LandingState();
}

class LandingState extends State<Landing> {
  BuildContext _context;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _context = context;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _buildStack(_height, _width),
    );
  }

  Stack _buildStack(double _height, double _width) {
    return Stack(
      fit: StackFit.expand,
      children: _buildStackChildren(_height, _width),
    );
  }

  List<Widget> _buildStackChildren(double _height, double _width) {
    return <Widget>[
      Image.asset(
        "assets/bg.gif",
        fit: BoxFit.fill,
      ),
      _buildColumn(_height, _width)
    ];
  }

  Widget _buildColumn(double _height, double _width) {
    return Stack(
      children: <Widget>[
        AbsorbPointer(
          absorbing: true,
          child: isLoading
              ? Container(
                  height: _height,
                  width: _width,
                  color: Colors.black87,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                height: _height * 0.5,
                width: _width * 0.5,
              ),
              _buildSignInButton(_height),
              RaisedButton(
                onPressed: handleSignOut,
                child: Text("Sign out"),
              )
            ],
          ),
        )
      ],
    );
  }

  RaisedButton _buildSignInButton(double _height) {
    return RaisedButton.icon(
      color: Colors.white,
      shape: StadiumBorder(),
      onPressed: _handleSignIn,
      icon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          "assets/google-icon.svg",
          height: _height * 0.05,
        ),
      ),
      label: Text("Sign in via Google"),
    );
  }

  void _handleSignIn() {
    setState(() {
      isLoading = true;
    });
    handleSignIn().then((FirebaseUser user) async {
      // print(user);

      Navigator.of(_context).pushNamed("/home");
    }).catchError((e) => print(e));
  }
}
