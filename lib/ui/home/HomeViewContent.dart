import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';

import 'dart:math' as math;

import 'package:sms_alert/ui/message/Policy/msg/PolicyMsgView.dart';

class HomeViewHeaderUI extends StatelessWidget {

  
  const HomeViewHeaderUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(child: Text(
        "Policies",
        style: TextStyle(fontSize: 20,letterSpacing: 10),)),
    );
  }
}


class HomeViewContentUI extends StatefulWidget {
   final  List<ConPolicy>? policies;
    final Function onTriggerState;

  HomeViewContentUI({Key? key, required this.policies, required this.onTriggerState}) : super(key: key);

  @override
  _HomeViewContentUIState createState() => _HomeViewContentUIState();
}

class _HomeViewContentUIState extends State<HomeViewContentUI> {



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(10),
       child: widget.policies != null ? ListView.builder(
         shrinkWrap: true,
         itemCount:widget.policies?.length ,
         itemBuilder: (context,int index){
          return item(widget.policies?[index]);       
          }
         ) : Text("")
    );
  }

  Widget item(ConPolicy? policy){
    return Column(
                    children: <Widget>[
                      Divider(height: 5.0,),
                      ListTile(
                        contentPadding: EdgeInsets.all(8),
                        title:(Text("${policy?.policyName}")),
                        subtitle: Text("${policy?.description}"),
                        trailing: (policy?.containNewMessage ?? 0) > 0 ? Container(
                          child:   CircleAvatar(
                            backgroundColor:Colors.green.shade400,
                            radius:10,
                            
                            child:Text(
                              '${policy?.containNewMessage}',
                              style: TextStyle(color:Colors.white),
                              )
                          ),
                        ):Text(""),
                        leading: Column(
                          children: <Widget>[
                            CircleAvatar(
                            backgroundColor:Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
                            radius:23,
                            
                            child:Text(
                              '${policy?.policyName![0].toUpperCase()}',
                              style: TextStyle(color:Colors.white),
                              )
                          )
                          ],
                        ),
                      onTap: (){
                        //go to PolicyMsgView Route
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PolicyMsgView(policyID: policy?.policyID ?? '',onTriggerState: (){
                            //in will triggeer when from perform navigation pop from PolicyMsgViewContent to HomeViewContent (this page)
                            //want to make sure,when user at PolicyMsgView Page, whwen go back to HomeView the notification (msg no read yet) will gone.
                            widget.onTriggerState();
                          },)
                        ));
                        
                      },),
                    ],
                    );  
  }

}