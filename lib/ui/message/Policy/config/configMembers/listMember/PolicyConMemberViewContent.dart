import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConContact.dart';


class PolicyConViewListMemberUI extends StatefulWidget {
  final List<ConContact?>? members;

  final Function onRemoveContact;
  PolicyConViewListMemberUI({Key? key, required this.members,required this.onRemoveContact})
      : super(key: key);

  @override
  _PolicyConViewListMemberUIState createState() =>
      _PolicyConViewListMemberUIState();
}

class _PolicyConViewListMemberUIState extends State<PolicyConViewListMemberUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: widget.members?.length ?? 0,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return item(widget.members?.elementAt(index));
      },
    ));
  }

  Widget item(ConContact? contact){
    return InkWell(
      onLongPress: (){

        //remove contact from current policy
        widget.onRemoveContact(contact?.contactID);

      },
      child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            subtitle: Text(contact?.phone ?? ""),
            leading: CircleAvatar(
              child: Text(contact?.displayName![0] ?? ""),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(contact?.displayName ?? ''),
          ),
    );
  }
}
