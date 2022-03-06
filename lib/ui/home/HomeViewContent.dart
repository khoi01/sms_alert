import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/repository/Repository.dart';
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
  HomeViewContentUI({Key? key}) : super(key: key);

  @override
  _HomeViewContentUIState createState() => _HomeViewContentUIState();
}

class _HomeViewContentUIState extends State<HomeViewContentUI> {

  List<ConPolicy>? _policies = []; 
  @override
  void initState() { 
    super.initState();
    getPolicies();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
       child: _policies != null ? ListView.builder(
         shrinkWrap: true,
         itemCount: _policies?.length ,
         itemBuilder: (context,int index){
          return Column(
                    children: <Widget>[
                      Divider(height: 5.0,),
                      ListTile(
                        contentPadding: EdgeInsets.all(8),
                        title:(Text("${_policies?[index].policyName}")),
                        subtitle: Text("${_policies?[index].description}"),
                        leading: Column(
                          children: <Widget>[
                            CircleAvatar(
                            backgroundColor:Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
                            radius:23,
                            
                            child:Text(
                              '${_policies?[index].policyName![0].toUpperCase()}',
                              style: TextStyle(color:Colors.white),
                              )
                          )
                          ],
                        ),
                      onTap: (){
                        //go to PolicyMsgView Route
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PolicyMsgView(policyID: _policies?[index].policyID,)
                        ));
                        
                      },),
                    ],
                    );         
          }
         ) : Text("")
    );
  }

  void getPolicies() async{
      List<Map<String,dynamic>> results = await Repository.query(ConPolicy.table);
    _policies = results.map((item) => ConPolicy.fromMap(item)).cast<ConPolicy>().toList();
      refresh();
  }

  void refresh(){
    setState(() {});
  }
}