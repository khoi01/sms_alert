import 'package:flutter/material.dart';
import 'package:sms_alert/components/ComponentSearchBarLocation.dart';
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/models/db/ConContactMapPolicy.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:sms_alert/ui/home/HomeView.dart';
import 'package:sms_alert/ui/message/Policy/config/configMembers/selectNewMember/PolicyConNewMemberViewContent.dart';
import 'package:sms_alert/utils/contacts.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';

class PolicyConNewMemberView extends StatefulWidget {
  final String policyID;
  final List<ConContact?>? existedMembers;

  const PolicyConNewMemberView(
      {Key? key, required this.existedMembers, required this.policyID})
      : super(key: key);

  @override
  State<PolicyConNewMemberView> createState() => _PolicyConNewMemberViewState();
}

class _PolicyConNewMemberViewState extends State<PolicyConNewMemberView> {
  List<ConContact?>? _selectedMembers = [];
  bool _isShowProgress = true;
  List<Contact>? _filteredContacts;
  List<Contact>? _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ComponentSearchBarLocation(
            title: "Members..",
            contacts: _contacts,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            onCallbackFilteredItem: (filteredContacts) {
              setState(() {
                _filteredContacts = filteredContacts;
              });
            }),
        body: Container(
          child: Column(children: [
            SelectedMemberUI(
              onSave: () {
                save();
                WidgetRef.showToasted("New Member added into policy", true);
              },
              existedMembers: widget.existedMembers,
              selectedMembers: _selectedMembers,
            ),
            _isShowProgress
                ? CircularProgressIndicator()
                : ListAvailableContact(
                    contacts: _filteredContacts,
                    existedMembers: widget.existedMembers,
                    onSelectecContact:
                        (bool isRegisterNewMember, ConContact conContact) {
                      setState(() {
                        //add contact as member policy
                        if (isRegisterNewMember) {
                          _selectedMembers?.add(conContact);
                        } else {
                          _selectedMembers?.removeWhere(
                              //remove contact as member policy
                              (element) => element?.phone == conContact.phone);
                        }
                      });
                    },
                  )
          ]),
        ));
  }

  void getContacts() {
    ContactInfo.getContacts().then((contacts) {
      //remove existed member
      widget.existedMembers?.forEach((contact) {
        contacts.removeWhere(
            (element) => element.displayName == contact?.displayName);
      });

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
        _isShowProgress = false;
      });
    });
  }

  void save() {
    widget.existedMembers?.forEach((existedMember) {
      _selectedMembers?.removeWhere(
          (newMember) => newMember?.contactID == existedMember?.contactID);
    });

    _selectedMembers?.forEach((contact) async {
      dynamic result1 = await Repository.insert(ConContact.table, contact!);
      print("[ConContact]Create :$result1");

      ConContactMapPolicy conContactMapPolicy = new ConContactMapPolicy(
          contactID: contact.contactID,
          policyID: widget.policyID,
          createdDate: DateTime.now().millisecondsSinceEpoch.toString(),
          createdBy: StringRef.user);

      dynamic result3 = await Repository.insert(
          ConContactMapPolicy.table, conContactMapPolicy);

      print("[ConContactMapPolicy]Create :$result3");

      //go back to main
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
        (Route<dynamic> route) => false,
      );
    });
  }
}
