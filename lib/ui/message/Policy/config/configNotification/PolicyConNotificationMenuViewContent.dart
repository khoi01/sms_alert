import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PolicyConNotificationEnableDisableUI extends StatefulWidget {
  final int? enableNotification;
  final Function onEnableNotification;
  const PolicyConNotificationEnableDisableUI(
      {Key? key, required this.enableNotification,required this.onEnableNotification})
      : super(key: key);

  @override
  State<PolicyConNotificationEnableDisableUI> createState() =>
      _PolicyConNotificationEnableDisableUIState();
}

class _PolicyConNotificationEnableDisableUIState
    extends State<PolicyConNotificationEnableDisableUI> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Card(
          margin: EdgeInsets.all(5),
          child:
              Container(
                child: Row(
                
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
        Text("Enable Notification"),
        FlutterSwitch(
          value: widget.enableNotification == 1 ? true : false,
          onToggle: (bool value) {
            widget.onEnableNotification(value);
          },
        )
      ]),
              )),
    );
  }
}
