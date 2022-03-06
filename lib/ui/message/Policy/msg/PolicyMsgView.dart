import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';
import 'package:sms_alert/ui/message/Policy/config/menu/PolicyConMenuView.dart';
import 'package:sms_alert/ui/message/Policy/msg/PolicyMsgViewContent.dart';

class PolicyMsgView extends StatefulWidget {

  final String? policyID;

  PolicyMsgView({Key? key, this.policyID}) : super(key: key);

  @override
  _PolicyMsgViewState createState() => _PolicyMsgViewState();
}


class _PolicyMsgViewState extends State<PolicyMsgView> {


  String? _policyName;

  @override
  void initState() { 
    super.initState();
    getConPolicy();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(_policyName??''),
        backgroundColor: Colors.white10,
        actions: <Widget>[
          _simplePopup(),
        ],
      ),
      body: ListView(
        children:<Widget>[
            PolicyMsgViewContentUI(policyID: widget.policyID,),
        ]
      )
    );
  }

    void getConPolicy() async{
    
    ConPolicy? conPolicy = await PolicyRepository.getPolicyById(widget.policyID);

    if(conPolicy != null){
        _policyName = conPolicy.policyName;
    }

    refresh();

  }

  void refresh(){
    setState(() { });
  }

  //menu pop 
Widget _simplePopup() => PopupMenuButton<int>(
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Policy Info"),
                ),
                // PopupMenuItem(
                //   value: 2,
                //   child: Text("Create Filter"),
                // ),
                
              ],
              onSelected: (value) async{
                if(value == 1){
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => PolicyConMenuView(policyID: widget.policyID,) 
                    ));
                  }else{                  
              
                  }
              
              },
        );
}


