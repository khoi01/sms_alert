import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/models/db/ConContactMapPolicy.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/ui/home/HomeView.dart';
import 'package:sms_alert/utils/db.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';
import 'package:contacts_service/contacts_service.dart';

import 'PolicyCreateViewContent.dart';

class PolicyCreateView extends StatefulWidget {

  final List<Contact> contacts;
  
  PolicyCreateView({Key key,this.contacts}) : super(key: key);

  @override
  _PolicyCreateViewState createState() => _PolicyCreateViewState();
}

class _PolicyCreateViewState extends State<PolicyCreateView> {
  
  final _formState = GlobalKey<FormState>();
  final _policyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(StringRef.createPolicyTitle),
        backgroundColor: Colors.white10,
        actions: <Widget>[
          //menu
          FlatButton(
            child: WidgetRef.customText(text:"Submit"),
            onPressed: (){
              if(_formState.currentState.validate()){
                  
                  isAlreadyExisted(_policyNameController.text).then((value) {
                      if(value){
                          WidgetRef.showToasted("Policy Name already exist,please used another name",false);
                      }else{
                        _save();
                        WidgetRef.showToasted("Save Success..", true);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeView()), 
                        (Route<dynamic> route) => false,
                        );
                      }
                  });
              }
            },
          )        
          ],
      ),
      body: ListView(
        children:<Widget>[
            PolicyCreateViewFormUI(formState: _formState,policyNameController:_policyNameController,),
            PolicyCreateMemberUI(members: widget.contacts.length,),
            PolicyCreateListUI(contacts:widget.contacts,),
        ]
      ),
    );
  }

  void _save() async{
    
    var policyID = DB.generateId();
    String date = DateTime.now().toIso8601String();
    
    ConPolicy conPolicy = new ConPolicy(
      policyID: policyID,
      policyName: _policyNameController.text,
      description: StringRef.empty,
      createdDate: date,
      createdBy: StringRef.user
    );

    dynamic result = await Repository.insert(ConPolicy.table,conPolicy);

    print("[ConPolicy]Create :$result");

    widget.contacts.forEach((contact) async {
      var contactID = DB.generateId();

      ConContact conContact = new ConContact(
        contactID:  contactID,
        displayName:  contact.displayName,
        givenName:  contact.givenName,
        middleName: contact.middleName,
        phone: contact.phones.first.value,
        createdDate: date,
        createdBy:  StringRef.user,
      );


      dynamic result2 = await Repository.insert(ConContact.table,conContact);
      print("[ConContact]Create :$result2");


      ConContactMapPolicy conContactMapPolicy = new ConContactMapPolicy(
        contactID: contactID,
        policyID: policyID,
        createdDate: date,
        createdBy: StringRef.user
      );

    dynamic result3 = await Repository.insert(ConContactMapPolicy.table,conContactMapPolicy);

    print("[ConContactMapPolicy]Create :$result3");

    });


    
  }

  Future<bool> isAlreadyExisted(String policyName) async{
    
    bool isAlreadyExited = true;

    ConPolicy conPolicy = await PolicyRepository.getPolicyByName(policyName);
    
    if(conPolicy == null)
      isAlreadyExited = false;
    
    return isAlreadyExited;

  }
}