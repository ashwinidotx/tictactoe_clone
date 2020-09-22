import 'package:flutter/material.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool playerTurn = true; // true for player 1 (X), false for player 2 (O)
  List<String> inSquare = ['', '', '', '', '', '', '', '', ''];
  int xScore = 0;
  int oScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Player X : $xScore',
                          style: kScoreBoardStyle,
                        ),
                        Text(
                          'Player O : $oScore',
                          style: kScoreBoardStyle,
                        ),
                      ],
                    ),
                    Text(
                      '${_currentTurn()}\'s Turn : ',
                      style: kScoreBoardStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _onTapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[600],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            inSquare[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'TIC TAC TOE',
                      style: kHeading,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      child: Text(
                        'New Game',
                        style: kScoreBoardStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          xScore = 0;
                          oScore = 0;
                          inSquare = ['', '', '', '', '', '', '', '', ''];
                          filledBoxes = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      if (inSquare[index] == '') {
        filledBoxes++;
        playerTurn ? inSquare[index] = 'X' : inSquare[index] = 'O';
      }

      playerTurn = !playerTurn;
      _checkWinner(inSquare);
    });
  }

  String _currentTurn() {
    if (playerTurn == true)
      return 'X';
    else
      return 'O';
  }

  void _showWinner(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  setState(() {
                    // clear board
                    inSquare = ['', '', '', '', '', '', '', '', ''];
                    filledBoxes = 0;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
            title: Center(
              child: Text(
                'Game Over\n$winner Won.\n',
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
    setState(() {
      if (winner == 'X') {
        xScore++;
      } else {
        oScore++;
      }
    });
    // make playerTurn true so X always has the first move in a new game.
    playerTurn = true;
  }

  void _checkWinner(List<String> inSquare) {
    //row 1
    if (inSquare[0] == inSquare[1] &&
        inSquare[0] == inSquare[2] &&
        inSquare[0] != '') {
      _showWinner(inSquare[0]);
    } // row 2
    else if (inSquare[3] == inSquare[4] &&
        inSquare[3] == inSquare[5] &&
        inSquare[3] != '') {
      _showWinner(inSquare[3]);
    } // row 3
    else if (inSquare[6] == inSquare[7] &&
        inSquare[6] == inSquare[8] &&
        inSquare[6] != '') {
      _showWinner(inSquare[6]);
    } // col 1
    else if (inSquare[0] == inSquare[3] &&
        inSquare[0] == inSquare[6] &&
        inSquare[0] != '') {
      _showWinner(inSquare[0]);
    } // col 2
    else if (inSquare[1] == inSquare[4] &&
        inSquare[1] == inSquare[7] &&
        inSquare[1] != '') {
      _showWinner(inSquare[1]);
    } //col 3
    else if (inSquare[2] == inSquare[5] &&
        inSquare[2] == inSquare[8] &&
        inSquare[2] != '') {
      _showWinner(inSquare[2]);
    } // diagonal 1
    else if (inSquare[0] == inSquare[4] &&
        inSquare[0] == inSquare[8] &&
        inSquare[0] != '') {
      _showWinner(inSquare[0]);
    } // diagonal 2
    else if (inSquare[2] == inSquare[4] &&
        inSquare[2] == inSquare[6] &&
        inSquare[2] != '') {
      _showWinner(inSquare[2]);
    } else if (filledBoxes == 9) {
      _showDraw();
    }
  }

  void _showDraw() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  setState(() {
                    // clear board
                    inSquare = ['', '', '', '', '', '', '', '', ''];
                    filledBoxes = 0;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
            title: Center(
              child: Text(
                'Game Draw.\n',
                textAlign: TextAlign.center,
              ),
            ),
          );
        });

    // make playerTurn true so X always has the first move in a new game.
    playerTurn = true;
  }
}
