import 'package:flutter/material.dart';
import 'package:tictactoe/widgets/game_page/game_page_widgets.dart';

class BotGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            BackBtn(),
            SizedBox(
              height: size.height * 0.02,
            ),
            Results(),
            SizedBox(
              height: size.height * 0.02,
            ),
            Column(
              children: [
                WhoseMove(),
                Board(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
