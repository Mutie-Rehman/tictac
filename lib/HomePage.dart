// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true; //first player is O
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 24);
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: const Color.fromARGB(255, 5, 36, 59),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Player O",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          oScore.toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Player X",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          xScore.toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700)),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              width: 100,
              child: FloatingActionButton(
                onPressed: () {
                  _clearScreen();
                },
                backgroundColor: const Color.fromARGB(255, 5, 36, 59),
                child: const Text(
                  "Reset",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//Setting the state when user wants to enter X or O
  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = "O";
        filledBoxes += 1;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = "X";
        filledBoxes += 1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //case 1
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != "") {
      _showWinDialog(displayXO[0]);
    }

    //case 2
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != "") {
      _showWinDialog(displayXO[0]);
    }

    //case 3
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != "") {
      _showWinDialog(displayXO[1]);
    }

    //case 4
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != "") {
      _showWinDialog(displayXO[3]);
    }

    //case 5
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != "") {
      _showWinDialog(displayXO[2]);
    }

    //case 6
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != "") {
      _showWinDialog(displayXO[6]);
    }

    //case 7
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != "") {
      _showWinDialog(displayXO[0]);
    }

    //case 8
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != "") {
      _showWinDialog(displayXO[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("$winner is the winner"),
            actions: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Play Again"),
                ),
              )
            ],
          );
        });
    if (winner == "O") {
      oScore += 1;
    } else if (winner == "X") {
      xScore += 1;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Oops Draw"),
            actions: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const Text("Play Again"),
                ),
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = "";
      }
    });
    filledBoxes = 0;
  }

  void _clearScreen() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = "";
      }
    });
    filledBoxes = 0;
    xScore = 0;
    oScore = 0;
  }
}
