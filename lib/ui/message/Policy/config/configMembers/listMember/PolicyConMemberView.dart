import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/repository/ContactMapPolicyRepository.dart';
import 'package:sms_alert/ui/message/Policy/config/configMembers/listMember/PolicyConMemberViewContent.dart';
import 'package:sms_alert/ui/message/Policy/config/configMembers/selectNewMember/PolicyConNewMemberView.dart';

import 'package:sms_alert/utils/widgets.dart';

class PolicyConMemberView extends StatefulWidget {
  final String policyID;

  const PolicyConMemberView({Key? key,required this.policyID}) : super(key: key);

  @override
  State<PolicyConMemberView> createState() => _PolicyConMemberViewState();
}

class _PolicyConMemberViewState extends State<PolicyConMemberView> {
  List<ConContact?>? _members;
  bool _showProgress = true;

  @override
  void initState() {
    super.initState();
    getExistedMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
        backgroundColor: Colors.white10,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _showProgress ? Text("") : InkWell(
              onTap: () {
                // Go to another page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PolicyConNewMemberView(existedMembers: _members,policyID: widget.policyID,)));
              },
              child: Icon(
                FontAwesomeIcons.plus,
              ),
            ),
          )
        ],
      ),
      body: ListView(children: <Widget>[
        _showProgress
            ? CircularProgressIndicator()
            : PolicyConViewListMemberUI(
                members: _members,
                onRemoveContact: (contactID) {
                  setState(() {
                    //remove member from this policy
                    removeContactFromCurrentPolicy(widget.policyID, contactID);

                    //re-iniitlize member
                    getExistedMember();
                  });
                },
              ),
      ]),
    );
  }

  void getExistedMember() async {
    ContactMapPolicyRepository.getMembersByPolicyID(widget.policyID)
        .then((members) {
      setState(() {
        _members = members;
        _showProgress = false;
      });
    });
  }

  void removeContactFromCurrentPolicy(String? policyID, String? contactID) {
    ContactMapPolicyRepository.removeContactByPolicyIDAndContactID(
            policyID, contactID)
        .then((isDelete) {
      if (isDelete) {
        WidgetRef.showToasted(
            "Success remove member from current policy..", true);
      } else {
        WidgetRef.showToasted("Failed remove member", true);
      }
    });
  }
}
