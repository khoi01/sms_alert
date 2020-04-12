import 'package:flutter/material.dart';
import 'package:sms_alert/ui/message/Policy/config/menu/PolicyConMenuViewContent.dart';

class PolicyConMenuView extends StatefulWidget {

final String policyID;

  PolicyConMenuView({Key key, this.policyID}) : super(key: key);

  @override
  _PolicyConMenuViewState createState() => _PolicyConMenuViewState();
}

class _PolicyConMenuViewState extends State<PolicyConMenuView> {

  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Policy Settings"),
        backgroundColor: Colors.white10,
        actions: [
          
        ],
      ),
      body: ListView(
        children:<Widget>[
          PolicyConViewMenuContentUI(policyID: widget.policyID,),
        ]
      ) ,
    );
  }
}