import 'package:flutter/material.dart';
import './Board.dart';

void main() {
  runApp(TicTacToe());
}

class TicTacToe extends StatelessWidget {
  final bool pressed = false;

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: Colors.black),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Tic Tac Toe'),
            ),
            body: Column(children: <Widget>[
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Text('Tic Tac Toe',
                    style: TextStyle(fontSize: 34, color: Colors.white)),
              ),
              Board(),
            ])));
  }
}
