import 'package:flutter/material.dart';
import 'package:sms_alert/ui/message/Policy/config/configMessage/PolicyConMessageMenuViewContent.dart';

class PolicyConMessageMenuView extends StatefulWidget {

  final String policyID;
  const PolicyConMessageMenuView({Key? key,required  this.policyID}) : super(key: key);

  @override
  State<PolicyConMessageMenuView> createState() => _PolicyConMessageMenuViewState();
}

class _PolicyConMessageMenuViewState extends State<PolicyConMessageMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Message Configuration"),
        backgroundColor: Colors.white10,
        actions: [
          
        ],
      ),
      body: ListView(
        children:<Widget>[
          PolicyConMessageContentUI(policyID: widget.policyID,),
        ]
      ) ,
    );
  }
}