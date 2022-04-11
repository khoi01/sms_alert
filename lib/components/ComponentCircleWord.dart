import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';

class ComponentCircleWord extends StatelessWidget {
  final ConWord? conWord;
  const ComponentCircleWord({Key? key, required this.conWord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(2),
      child: Text(conWord?.word ?? ""),
    );
  }
}
