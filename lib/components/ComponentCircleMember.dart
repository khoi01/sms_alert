import 'package:flutter/material.dart';

class ComponentCircleMember extends StatefulWidget {

  final String? displayName;
  final String? componentCircleId; //refer this component id (easy to find this component in the listview)
  final Color? backgroundColor;
  const ComponentCircleMember({Key? key,required  this.displayName, this.componentCircleId, this.backgroundColor}) : super(key: key);

  @override
  State<ComponentCircleMember> createState() => _ComponentCircleMemberState();
}

class _ComponentCircleMemberState extends State<ComponentCircleMember> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: widget.backgroundColor ?? Colors.black ,
            radius: 20,
            child: Text(
              widget.displayName?.substring(0,2) ?? "",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ), //Text
          ),
          Text((widget.displayName?.length ?? 0) >= 7 ? widget.displayName?.substring(0,7) ?? widget.displayName.toString() : widget.displayName.toString())

        ],
      ),
    );
  }
}