import 'package:flutter/material.dart';

class ComponentSettingFlag extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool status;
  final Function onClick;
  const ComponentSettingFlag(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.status,
      required this.onClick})
      : super(key: key);

  @override
  State<ComponentSettingFlag> createState() => _ComponentSettingFlagState();
}

class _ComponentSettingFlagState extends State<ComponentSettingFlag> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      widget.icon,
                      size: 30,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(letterSpacing: 2, fontSize: 25),
                    ),
                    Icon(
                      Icons.circle,
                      size: 30,
                      color: widget.status ? Colors.green : Colors.red,
                    )
                  ]),
              Text(
                widget.description,
                style: TextStyle(letterSpacing: 1, fontSize: 14),
              ),
              TextButton(
                  onPressed: () {
                    widget.onClick();
                  },
                  child: Text(
                    "Enable",
                    style: TextStyle(letterSpacing: 1),
                  )),Text("Note: If want to disable this permission,you must change the permission from the settings of the app. thank you",style: TextStyle(fontSize: 12),)
            ],
          ),
        ));
  }
}
