import 'dart:math';
import 'package:flutter/material.dart';
import 'package:customprompt/customprompt.dart';

class GameProvider extends ChangeNotifier {
  bool xMove = true;
  String winner = '';
  bool draw = false;
  int movesCounter = 0;
  bool botGame = false;

  int xWins = 0;
  int oWins = 0;
  int draws = 0;
  bool restart = false;

  List movesList = List.generate(3, (i) => List.filled(3, ''), growable: false);

  void saveChoice(int row, int place, BuildContext context) {
    final bool original = xMove;
    if (xMove) {
      movesList[row][place] = 'X';
    } else {
      movesList[row][place] = 'O';
    }

    xMove = !xMove;
    movesCounter++;

    checkWinner(context);
    notifyListeners();
    debugPrint("BOTGAME: $botGame ORIGINAL: $original");
    if (botGame && original) {
      debugPrint("HI");
      botMove(context);
    }
  }

  void botMove(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (winner != "") {
        return;
      }
      final List<List<int>> emptySpots = [];
      for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 3; y++) {
          if (movesList[x][y] == "") {
            emptySpots.add([x, y]);
          }
        }
      }
      final rng = Random();
      final move = emptySpots[rng.nextInt(emptySpots.length)];
      movesList[move[0]][move[1]] = "O";
      debugPrint("DOING BOT MOVE $move");
      xMove = !xMove;
      checkWinner(context);
      notifyListeners();
    });
  }

  void checkWinner(BuildContext context) {
    const String x = 'X';
    const String o = 'O';

    for (int i = 0; i < 3; i++) {
      // horizontal check
      if (movesList[i][0] == x &&
          movesList[i][1] == x &&
          movesList[i][2] == x) {
        winner = x;
      } else if (movesList[i][0] == o &&
          movesList[i][1] == o &&
          movesList[i][2] == o) winner = o;

      // vertical check
      if (movesList[0][i] == x &&
          movesList[1][i] == x &&
          movesList[2][i] == x) {
        winner = x;
      } else if (movesList[0][i] == o &&
          movesList[1][i] == o &&
          movesList[2][i] == o) winner = o;

      // cross check
      if ((movesList[0][0] == x &&
              movesList[1][1] == x &&
              movesList[2][2] == x) ||
          (movesList[0][2] == x &&
              movesList[1][1] == x &&
              movesList[2][0] == x)) {
        winner = x;
      } else if ((movesList[0][0] == o &&
              movesList[1][1] == o &&
              movesList[2][2] == o) ||
          (movesList[0][2] == o &&
              movesList[1][1] == o &&
              movesList[2][0] == o)) winner = o;
    }
    if (winner == '' && movesCounter == 9) {
      draw = true;
    }

    if (winner != '' || draw == true) showModal(context);

    notifyListeners();
  }

  Future<void> showModal(BuildContext context) async {
    if (winner != '' || draw) {
      await CustomPrompt(
        context: context,
        animDuration: 100,
        color: Colors.black,
        type: Type.confirm,
        icon: const Icon(Icons.circle, size: 0),
        title: draw == true ? 'Draw!' : '$winner wins!',
        content: 'Continue Playing?',
        btnOneColor: Colors.grey[850],
        btnTwoColor: Colors.grey[850],
        btnOneText: const Text('Continue Playing',
            style: TextStyle(color: Colors.white)),
        btnTwoText:
            const Text('Main Menu', style: TextStyle(color: Colors.white)),
        transparent: true,
        btnOneOnClick: () {
          restartGame();
        },
        btnTwoOnClick: () {
          restartGame();
          xWins = 0;
          oWins = 0;
          draws = 0;
          botGame = false;
          Navigator.popUntil(context, ModalRoute.withName("/"));
        },
      ).alert();
    }

    notifyListeners();
  }

  void restartGame() {
    if (winner == 'X') {
      xWins++;
    }

    if (winner == 'O') {
      oWins++;
    }

    if (draw) {
      draws++;
    }

    restart = true;
    winner = '';
    draw = false;
    movesCounter = 0;
    movesList = List.generate(3, (i) => List.filled(3, ''), growable: false);
    notifyListeners();
  }

  void handleRestart() {
    restart = false;
    notifyListeners();
  }

  Border determineBorder(int row, int place) {
    Border border = Border.all(color: Colors.grey[700]);
    final BorderSide borderSide = BorderSide(color: Colors.grey[700]);

    if (row == 0 && place == 0) {
      border = Border(bottom: borderSide, right: borderSide);
    }
    if (row == 0 && place == 1) {
      border = Border(bottom: borderSide, right: borderSide, left: borderSide);
    }
    if (row == 0 && place == 2) {
      border = Border(bottom: borderSide, left: borderSide);
    }
    if (row == 1 && place == 0) {
      border = Border(bottom: borderSide, right: borderSide, top: borderSide);
    }
    if (row == 1 && place == 2) {
      border = Border(bottom: borderSide, left: borderSide, top: borderSide);
    }
    if (row == 2 && place == 0) {
      border = Border(top: borderSide, right: borderSide);
    }
    if (row == 2 && place == 1) {
      border = Border(right: borderSide, left: borderSide, top: borderSide);
    }
    if (row == 2 && place == 2) {
      border = Border(left: borderSide, top: borderSide);
    }

    return border;
  }

  double getAdaptiveTextSize(BuildContext context, double value) {
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
