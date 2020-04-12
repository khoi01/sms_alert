import 'package:flutter/material.dart';
import 'package:sms_alert/models/model/Policy.dart';
import 'package:sms_alert/repository/PolicyMsgRepository.dart';

class PolicyMsgViewContentUI extends StatefulWidget {

  final String policyID;


  PolicyMsgViewContentUI({Key key, this.policyID,}) : super(key: key);

  @override
  _PolicyMsgViewContentUIState createState() => _PolicyMsgViewContentUIState();
}

class _PolicyMsgViewContentUIState extends State<PolicyMsgViewContentUI> {

  List<Policy> _policies;

  @override
  void initState() {
    super.initState();
    getPolicyMsg();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      //height: MediaQuery.of(context).size.height,
       child: _policies != null 
       ? ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _policies.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(child: ListTile(title: Text(
                      _policies[index].policyMsgDetail.message),
                      subtitle: Text(
                        _policies[index].policyMsg.createdDate
                      ),))
                );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }


  void getPolicyMsg() async{ 

    //  List<Policy> policies = await PolicyMsgRepository.getPoliciesMsgByPolicyID(widget.policyID);

  PolicyMsgRepository.getPoliciesMsgByPolicyID(widget.policyID).then((policies){
  
  
     if(policies.length>0){
        _policies = policies;
      }


      refresh();
  });
     
  }

  void refresh(){
    setState(() {
      
    });
  }
}