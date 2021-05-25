import 'package:flutter/material.dart';
import 'package:tictactoe/providers/game_provider.dart';
import 'package:tictactoe/widgets/home_page/button.dart';
import 'package:provider/provider.dart';


class ButtonsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameProvider>();

    return Column(
      children: [
        // Button('Play Offline', Colors.white, () {
        //   debugger();
        //   Navigator.pushNamed(context, "/Game");
        // }),
        // Button('Play vs Bot', Colors.white, () {
        //   debugger();
        //   state.botGame = true;
        //   Navigator.pushNamed(context, "/BotGame");
        // }),
        Button('Play Offline', Colors.white, () {
          state.botGame = false;
          Navigator.pushNamed(context, "/game");
        }),
        Button('Play vs Bot', Colors.white, () {
          state.botGame = true;
          Navigator.pushNamed(context, "/botgame");
        }), 
      ],
    );
  }
}
