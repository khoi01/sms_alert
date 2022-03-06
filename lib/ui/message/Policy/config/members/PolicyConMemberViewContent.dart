import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/repository/ContactMapPolicyRepository.dart';

class PolicyConViewListMemberUI extends StatefulWidget {

  final String? policyID;
  PolicyConViewListMemberUI({Key? key, this.policyID}) : super(key: key);

  @override
  _PolicyConViewListMemberUIState createState() => _PolicyConViewListMemberUIState();
}

class _PolicyConViewListMemberUIState extends State<PolicyConViewListMemberUI> {

  List<ConContact?>? _members;

  @override
  void initState() { 
    getMember();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _members != null 
       ? ListView.builder(
              shrinkWrap: true,
              itemCount: _members?.length ?? 0,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                ConContact? contact = _members?.elementAt(index);
                return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                        subtitle: Text(contact?.phone ?? ""),
                    leading: CircleAvatar(
                            child: Text(contact?.displayName![0] ?? ""),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                          ),
                    title: Text(contact?.displayName ?? ''),
                  );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  
  void getMember() async{

    ContactMapPolicyRepository.getContactsByPolicyID(widget.policyID).then((members){

      _members = members;
       refresh();   
    });
  }

  void refresh() {
    setState(() {});
  }
}

