import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class IntroView extends StatefulWidget {
   IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final pages = [
    FirstIntro(),
    SecondIntro()
  ];

     late LiquidController liquidController;

  @override
  void initState() {
    super.initState();
       liquidController = LiquidController();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Builder(builder: (context) =>
              LiquidSwipe(
                initialPage: 0,
                  pages: pages,
                  liquidController: liquidController,
              )));
    
  }
}


class FirstIntro extends StatelessWidget {
  const FirstIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("FIrst")),
    );
  }
}


class SecondIntro extends StatelessWidget {
  const SecondIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Second")),
    );
  }
}