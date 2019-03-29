import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final List<String> options;
  final Function updateFunc;
  final String query;
  final String tag;

  CustomRadio({
    @required this.query,
    @required this.options,
    @required this.updateFunc,
    @required this.tag,
  });

  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> optionsList = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    optionsList.addAll(widget.options.map((i) => RadioModel(false, i)));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double min = h < w ? h : w;

    List<Widget> options = List.generate(optionsList.length, (int index) {
      return Container(
        margin:
            EdgeInsets.symmetric(vertical: min * 0.03, horizontal: min * 0.05),
        child: OutlineButton(
          padding: EdgeInsets.symmetric(
              vertical: min * 0.03, horizontal: min * 0.05),
          onPressed: () {
            widget.updateFunc(widget.tag, widget.options[index]);
            setState(() {
              optionsList.forEach((element) => element.isSelected = false);
              optionsList[index].isSelected = true;
            });
          },
          shape: StadiumBorder(),
          textColor:
              optionsList[index].isSelected ? Colors.white : Colors.white54,
          borderSide: BorderSide(
              color: optionsList[index].isSelected
                  ? Colors.white
                  : Colors.white54),
          child: Text(
            optionsList[index].text,
            style: TextStyle(
              fontSize: min * 0.05,
              fontWeight: optionsList[index].isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      );
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double k = height < width ? height : width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          widget.query,
          style: TextStyle(fontSize: k * 0.05, color: Colors.white),
        ),
        SizedBox(height: k * 0.05),
        buildOptions(options),
      ],
    );
  }

  Column buildOptions(List<Widget> options) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options,
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _item.isSelected ? Colors.black : Colors.transparent,
      child: Text(_item.text),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}
