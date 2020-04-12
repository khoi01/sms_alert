import 'package:flutter/material.dart';
import 'package:sms_alert/ui/message/Policy/config/members/PolicyConMemberView.dart';
import 'package:sms_alert/ui/message/Policy/config/word/PolicyConWordView.dart';

class PolicyConViewMenuContentUI extends StatefulWidget {

  final String policyID;

  PolicyConViewMenuContentUI({Key key, this.policyID}) : super(key: key);

  @override
  _PolicyConMenuViewContentUIState createState() => _PolicyConMenuViewContentUIState();
}

class _PolicyConMenuViewContentUIState extends State<PolicyConViewMenuContentUI> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
       Card(
        child: ListTile(
          leading: Icon(Icons.notifications),
          title: Text('notification configuration'),
          trailing: Icon(Icons.more_vert),
        )
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.filter_1),
          title: Text('Filter Configuration'),
          trailing: Icon(Icons.more_vert),
          onTap: (){
            
            Navigator.push(context,MaterialPageRoute(
             builder: (context) => PolicyConWordView(policyID: widget.policyID,)
            ));
            
          },
        )
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.perm_contact_calendar ),
          title: Text('Members'),
          trailing: Icon(Icons.more_vert),
          onTap: (){
            
            Navigator.push(context,MaterialPageRoute(
             builder: (context) => PolicyConMemberView(policyID: widget.policyID,)
            ));
            
          },
        )
      ),
  ],
),
    );
  }
}