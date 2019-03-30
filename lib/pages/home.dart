import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:style/constants.dart';

double height, width;
bool chat = false;

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

    void invertChat() {
      setState(() {
        chat = !chat;
      });
    }

    return Scaffold(
      floatingActionButton: chat
          ? Container()
          : FloatingActionButton(
              onPressed: invertChat,
              child: Icon(Icons.chat),
            ),
      appBar: AppBar(
        title: Text("Style"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: LayoutBuilder(
              builder: layoutBuilder,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: chat ? height : 0,
            child: Chat(invertChat),
          ),
        ],
      ),
    );
  }

  Widget layoutBuilder(BuildContext mContext, BoxConstraints boxConstraints) {
    height = boxConstraints.maxHeight;
    width = boxConstraints.maxWidth;

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

class Chat extends StatefulWidget {
  Function invertChat;
  Chat(this.invertChat);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ScrollController _scrollController;
  TextEditingController _textEditingController;
  List<Message> messages = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey.shade200,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.pink.shade800,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.pink,
                          child: ListTile(
                            subtitle: Text(
                              "Guest",
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text("Customer Support",
                                style: TextStyle(color: Colors.white)),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage("assets/dp.jpg"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, idx) {
                              return _buildMsg(messages[idx]);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(7.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.withOpacity(0.1),
                        Colors.deepPurple.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        iconSize: 18,
                        icon: Icon(Icons.attach_file),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: "Send a message.."),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      IconButton(
                        iconSize: 18,
                        icon: Icon(Icons.send),
                        onPressed: () {
                          String msg = _textEditingController.text;
                          if (msg != null) {
                            setState(
                              () {
                                messages
                                    .add(Message(isClient: false, msg: msg));
                              },
                            );
                            print(messages);
                            _textEditingController.clear();
                            _scrollController
                                .jumpTo(messages.length.toDouble());
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: widget.invertChat,
            ),
          )
        ],
      ),
    );
  }

  Container _buildMsg(Message message) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        message.isClient ? width * 0.8 : 8.0,
        8.0,
        message.isClient ? 8.0 : width * 0.8,
        8.0,
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: message.isClient ? Colors.teal.withOpacity(0.1) : Colors.white10,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Text(
        message.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class Message {
  String msg;
  bool isClient;
  Message({
    @required this.msg,
    @required this.isClient,
  });

  @override
  String toString() {
    return msg;
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
            colors: [widget.color, widget.color, Colors.white54],
            stops: [0.0, 0.25, 1.0],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
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
