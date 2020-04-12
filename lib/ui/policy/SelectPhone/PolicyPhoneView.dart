import 'package:flutter/material.dart';
import 'package:sms_alert/ui/policy/CreatePolicy/PolicyCreateView.dart';
import 'package:sms_alert/ui/policy/SelectPhone/PolicyPhoneViewContent.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';
import 'package:contacts_service/contacts_service.dart';

class PolicyPhoneView extends StatefulWidget {




  @override
  _PolicyPhoneViewState createState() => _PolicyPhoneViewState();
}

class _PolicyPhoneViewState extends State<PolicyPhoneView> {

   List<Contact> selectedContacts = new List<Contact>();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(StringRef.createPolicyTitle),
        backgroundColor: Colors.white10,
        actions: <Widget>[
          //menu
          FlatButton(
            child: WidgetRef.customText(text:"Next"),
            onPressed: (){
                 if(selectedContacts.length>0){
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PolicyCreateView(contacts: selectedContacts)
                  ));  
                 }else{
                   WidgetRef.showToasted("Select contact number",false);
                }          
            },
          )
        ],
      ),
      body: ListView(
        children:<Widget>[
         PolicyPhoneViewContentUI(selectedContacts: selectedContacts,),
        ]
      ),
    );
  }

}