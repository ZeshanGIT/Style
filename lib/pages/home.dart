import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:style/constants.dart';

double height, width;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> services;

  static List<Color> colors;

  static List<String> images;

  List<Widget> serviceItemList;

  List<Widget> widgetList;

  final Shader _textBG = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    colors = [
      Colors.lightBlue,
      Colors.pink,
      Colors.brown,
      Colors.purple,
      Colors.green,
      Colors.deepOrange,
    ];

    images = [
      'assets/Photography.png',
      'assets/Graphic Design.png',
      'assets/Pencil Sketching.png',
      'assets/App Development.png',
      'assets/Web Development.png',
      'assets/3D Printing.png',
    ];

    services = [
      Strings.photography,
      Strings.graphicDesigning,
      Strings.pencilSketching,
      Strings.appDevelopment,
      Strings.webDevelopment,
      Strings.printing3d,
    ];

    serviceItemList = List.generate(
      services.length,
      (i) {
        ServiceItem temp = ServiceItem(
          name: services[i],
          color: colors[i],
          image: images[i],
        );
        return temp;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Style"),
      ),
      body: Container(
        child: LayoutBuilder(
          builder: layoutBuilder,
        ),
      ),
    );
  }

  Widget layoutBuilder(BuildContext mContext, BoxConstraints boxConstraints) {
    height = boxConstraints.maxWidth;
    width = boxConstraints.maxHeight;

    widgetList = [
      Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: "Nexa",
                  foreground: Paint()..shader = _textBG,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: DateTime.now().hour > 16
                        ? "Good Morning ,\n\n"
                        : "Good Evening,\n\n",
                    style: TextStyle(fontSize: width * 0.03),
                  ),
                  TextSpan(
                    text: "Abhiroop",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              "assets/gm.png",
              fit: BoxFit.cover,
            ),
          )
        ],
      )
    ];
    widgetList.addAll(serviceItemList);
    return Container(
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.symmetric(horizontal: width / 27),
        itemCount: widgetList.length,
        itemBuilder: (bc, i) => widgetList[i],
        staggeredTileBuilder: (i) =>
            i != 0 ? StaggeredTile.count(1, 1) : StaggeredTile.count(2, 1),
        crossAxisCount: 2,
        crossAxisSpacing: width / 27,
        mainAxisSpacing: width / 27,
      ),
    );
  }
}

class ServiceItem extends StatefulWidget {
  final Color color;
  final String image;
  final String name;
  const ServiceItem({
    Key key,
    @required this.color,
    @required this.image,
    @required this.name,
  }) : super(key: key);

  @override
  _ServiceItemState createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
            isPressed = true;
          }),
      onTapUp: (_) => setState(() {
            isPressed = false;
          }),
      onTap: () => Navigator.of(context).pushNamed("/${widget.name}"),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 50),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.8),
              offset: Offset.zero,
              blurRadius: 0.02,
              spreadRadius: 0,
            )
          ],
          gradient: LinearGradient(
            colors: [widget.color, widget.color, widget.color.withOpacity(0.5)],
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(width * 0.02),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    width * 0.04, width * 0.04, width * 0.04, 0),
                child: Hero(
                  tag: widget.name,
                  child: Image.asset(
                    widget.image,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: width * 0.02),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.03,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return "Name: ${widget.name}, Image: ${widget.image}, Color: ${widget.color}\n";
  }
}
