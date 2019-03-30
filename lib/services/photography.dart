import 'package:flutter/material.dart';
import 'package:style/utilities/custom_radio.dart';

class Photography extends StatefulWidget {
  @override
  PhotographyState createState() => PhotographyState();
}

class PhotographyState extends State<Photography>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  List<Color> bgColors = [
    Colors.lightBlue,
    Colors.pink,
    Colors.brown,
    Colors.purple,
    Colors.green,
    Colors.deepOrange,
  ];

  int i = 0;

  Map<String, dynamic> map = {
    "type": "",
    "package": "",
    "item": "",
    "tier": "",
    "date": "",
  };

  void updateSelected(String tag, String selectedItem) {
    map[tag] = selectedItem;
    print(map);
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() => setState(() => i = pageController.page.toInt()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double k = h < w ? h : w;

    bool next = true;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: bgColors[i],
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(k * 0.1),
                  child: Text(
                    "Photography",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: k * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(k * 0.08),
                  child: IconButton(
                    iconSize: k * 0.1,
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: k * 0.4),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 6,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (bc, i) {
                    switch (i) {
                      case 0:
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: k * 0.2),
                              child: Hero(
                                tag: "Photo",
                                child: Image.asset("assets/Photography.png"),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        );

                      case 1:
                        return CustomRadio(
                          query: "Choose your type.",
                          options: ["Personal", "Business"],
                          updateFunc: updateSelected,
                          tag: "type",
                          map: map,
                        );

                      case 2:
                        return CustomRadio(
                          query: "Choose your package.",
                          options: ["Photo", "Photo + Video"],
                          updateFunc: updateSelected,
                          tag: "package",
                          map: map,
                        );

                      case 3:
                        return map["type"] == "Personal"
                            ? CustomRadio(
                                options: [
                                  "Engagement",
                                  "Baby/Kids",
                                  "Birthday",
                                  "Pre-Wedding"
                                ],
                                query: "Choose your item",
                                updateFunc: updateSelected,
                                tag: "item",
                                map: map,
                              )
                            : CustomRadio(
                                options: ["Product", "Model", "Event"],
                                query: "Choose your item",
                                tag: "item",
                                updateFunc: updateSelected,
                                map: map,
                              );
                      case 4:
                        return map["package"] == "Photo"
                            ? CustomRadio(
                                options: ["Bronze", "Platinunm"],
                                query: "Choose your tier",
                                updateFunc: updateSelected,
                                tag: "tier",
                                map: map,
                              )
                            : CustomRadio(
                                options: ["Platinum"],
                                query: "Choose your tier",
                                tag: "tier",
                                updateFunc: updateSelected,
                                map: map,
                              );
                      case 5:
                        return FlatButton(
                          onPressed: () {
                            setState(() async {
                              DateTime dt = await showDatePicker(
                                context: bc,
                                initialDate: DateTime.now(),
                                lastDate: DateTime(2020),
                                firstDate: DateTime.now(),
                              );
                              map["date"] = dt.toString();
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: k * 0.1),
                              Text(
                                "Choose your date ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: k * 0.05,
                                ),
                              ),
                              Text(
                                map["date"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: k * 0.05,
                                ),
                              ),
                            ],
                          ),
                        );
                        // showDatePicker(
                        //     context: bc,
                        //     firstDate: DateTime.now(),
                        //     initialDate: DateTime.now()..add(Duration(days: 1)),
                        //     lastDate: DateTime.now());

                        break;

                      default:
                        return Container();
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: FlatButton(
                  padding: EdgeInsets.all(k * 0.05),
                  onPressed: () => pageController.animateToPage(
                      pageController.page.toInt() - 1,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut),
                  child: Text(
                    "<",
                    style: TextStyle(
                      fontSize: k * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: next ? 1 : 0,
                  child: FlatButton(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(k * 0.05),
                    onPressed: () {
                      pageController.animateToPage(
                          pageController.page.toInt() + 1,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      ">",
                      style: TextStyle(
                        fontSize: k * 0.1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
