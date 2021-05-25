import 'package:flutter/material.dart';
import 'package:tictactoe/widgets/general/shapes.dart';
import 'package:tictactoe/widgets/home_page/home_page_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final GameProvider state = context.watch<GameProvider>();
    final Size size = MediaQuery.of(context).size;
    // final TextStyle playerName = TextStyle(
    //   fontSize: state.getAdaptiveTextSize(context, 16),
    //   color: Colors.grey[500],
    // );

    return Scaffold(
            backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(children: [
          SvgPicture.asset(
            'assets/bg/BG.svg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: size.height * 0.07, top: size.height * 0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        XSign(size.width * 0.15),
                        Circle(size.width * 0.15),
                      ],
                    ),
                    const Text(
                      "TIC TAC TOE",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: size.height * 0.2),
                    ButtonsWrapper(),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
