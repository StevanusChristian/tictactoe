import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/game_provider.dart';

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onPressed;

  const Button(this.text, [this.color, this.onPressed]);

  @override
  Widget build(BuildContext context) {
    final GameProvider state = context.watch<GameProvider>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      width: size.width * 0.5,
      height: size.height * 0.05,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
          side: BorderSide(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        )),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Montserrat',
            fontSize: state.getAdaptiveTextSize(context, 16),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
