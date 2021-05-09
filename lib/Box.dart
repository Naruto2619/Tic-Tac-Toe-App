import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  int index;
  List<List<String>> stat;
  final Function apdate;
  Box(this.stat, this.index, this.apdate);
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  var s, i, j;
  void initState() {
    switch (widget.index) {
      case 0:
        i = j = 0;
        break;
      case 1:
        i = 0;
        j = 1;
        break;
      case 2:
        i = 0;
        j = 2;
        break;
      case 3:
        i = 1;
        j = 0;
        break;
      case 4:
        i = j = 1;
        break;
      case 5:
        i = 1;
        j = 2;
        break;
      case 6:
        i = 2;
        j = 0;
        break;
      case 7:
        i = 2;
        j = 1;
        break;
      case 8:
        i = 2;
        j = 2;
        break;
    }
  }

  String text = '';
  bool isOver = false;
  bool isactive = true;
  bool turn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: FlatButton(
          onPressed: isOver
              ? null
              : () {
                  isOver = widget.apdate(i, j);
                },
          child: Text(
            '${widget.stat[i][j]}',
            style: TextStyle(color: Colors.white, fontSize: 80),
          )),
    );
  }
}
