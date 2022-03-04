import 'package:flutter/material.dart';
import 'package:sms_alert/ui/message/Policy/config/selectWord/PolicyConSelectWordView.dart';
import 'package:sms_alert/ui/message/Policy/config/word/PolicyConWordViewContent.dart';
import 'package:sms_alert/utils/widgets.dart';

class PolicyConWordView extends StatefulWidget {
  final String policyID;

  PolicyConWordView({Key key, this.policyID}) : super(key: key);

  @override
  _PolicyConWordViewState createState() => _PolicyConWordViewState();
}

class _PolicyConWordViewState extends State<PolicyConWordView> {
 
 @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Configuration"),
        backgroundColor: Colors.white10,
        actions: [
          TextButton(child: WidgetRef.customText(
            text: "Add Filter"),
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PolicyConSelectWordView(policyID: widget.policyID,)
                ));
            },
          ),
        ],
      ),
      body: ListView(
        children:<Widget>[
         // PolicyConWordFormViewUI(policyID: widget.policyID,),
          PolicyWordListViewUI(policyID: widget.policyID,)
        ]
      ),
    );
  }
}