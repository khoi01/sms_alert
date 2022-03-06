import 'package:flutter/material.dart';
import 'package:sms_alert/ui/message/Policy/config/members/PolicyConMemberViewContent.dart';

class PolicyConMemberView extends StatelessWidget {

  final String? policyID;

  const PolicyConMemberView({Key? key, this.policyID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Members"),
        backgroundColor:Colors.white10,
        actions:[

        ]
      ),
      body: ListView(
        children:<Widget>[
          PolicyConViewListMemberUI(policyID:policyID),
        ]
      ),
    );
  }
}