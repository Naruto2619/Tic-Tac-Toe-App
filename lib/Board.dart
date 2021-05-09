import 'package:flutter/material.dart';
import './Box.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  String res = null;
  var scores = {'X': -10, 'O': 10, 'tie': 0};
  List<List<String>> stat = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];
  void reset() {
    setState(() {
      res = null;
      stat = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
      ];
    });
  }

  int minimax(board, depth, isMaximizing) {
    var result = checkWinner(stat);
    if (result != null) {
      return scores[result];
    }

    if (isMaximizing) {
      var bestScore = -100;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          // Is the spot available?
          if (board[i][j] == '') {
            board[i][j] = 'O';
            var score = minimax(board, depth + 1, false);
            board[i][j] = '';
            int larger = score > bestScore ? score : bestScore;
            bestScore = larger;
          }
        }
      }
      return bestScore;
    } else {
      var bestScore = 100;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          // Is the spot available?
          if (board[i][j] == '') {
            board[i][j] = 'X';
            var score = minimax(board, depth + 1, true);
            board[i][j] = '';
            int smaller = score < bestScore ? score : bestScore;
            bestScore = smaller;
          }
        }
      }
      return bestScore;
    }
  }

  Map<String, int> bestMove(List<List<String>> sta) {
    // AI to make its turn
    var bestScore = -100;
    var move;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (sta[i][j] == '') {
          sta[i][j] = 'O';
          var score = minimax(sta, 0, false);
          sta[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            move = {'i': i, 'j': j};
          }
        }
      }
    }
    return move;
  }

  bool equals3(String a, String b, String c) {
    return a == b && b == c && a != '';
  }

  String checkWinner(List<List<String>> sta) {
    var winner = null;

    // horizontal
    for (var i = 0; i < 3; i++) {
      if (equals3(sta[i][0], sta[i][1], sta[i][2])) {
        winner = sta[i][0];
      }
    }

    // Vertical
    for (var i = 0; i < 3; i++) {
      if (equals3(sta[0][i], sta[1][i], sta[2][i])) {
        winner = sta[0][i];
      }
    }

    // Diagonal
    if (equals3(sta[0][0], sta[1][1], sta[2][2])) {
      winner = sta[0][0];
    }
    if (equals3(sta[2][0], sta[1][1], sta[0][2])) {
      winner = sta[2][0];
    }

    var openSpots = 0;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (sta[i][j] == '') {
          openSpots++;
        }
      }
    }
    if (winner == null && openSpots == 0) {
      return 'tie';
    } else {
      return winner;
    }
  }

  String text = '';
  bool turn = false;
  Map ai;
  bool update(int i, int j) {
    setState(() {
      stat[i][j] = 'X';
      res = checkWinner(stat);
      if (res != null) return;
      ai = bestMove(stat);
      stat[ai['i']][ai['j']] = 'O';
      res = checkWinner(stat);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: (res == null)
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return Box(stat, index, update);
                })
            : res == 'tie'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                          'Tie',
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                        RaisedButton(
                            color: Colors.white,
                            onPressed: reset,
                            child: Text('RESET',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.blue)))
                      ])
                : res == 'X'
                    ? Text('X Wins',
                        style: TextStyle(fontSize: 50, color: Colors.white))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                              'O Wins',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.white),
                            ),
                            RaisedButton(
                                color: Colors.white,
                                onPressed: reset,
                                child: Text('RESET',
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.blue)))
                          ]));
  }
}
