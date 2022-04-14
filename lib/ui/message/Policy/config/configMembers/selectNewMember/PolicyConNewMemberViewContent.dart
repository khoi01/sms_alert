import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sms_alert/components/ComponentCircleMember.dart';
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:sms_alert/utils/db.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';

class SelectedMemberUI extends StatefulWidget {
  final List<ConContact?>? existedMembers;
  final List<ConContact?>? selectedMembers;
  final Function onSave;
  const SelectedMemberUI(
      {Key? key,
      required this.existedMembers,
      required this.selectedMembers,
      required this.onSave})
      : super(key: key);

  @override
  State<SelectedMemberUI> createState() => _SelectedMemberUIState();
}

class _SelectedMemberUIState extends State<SelectedMemberUI> {
  @override
  void initState() {
    super.initState();
    addExistedMemberIntoCircleComponent();
  }

  //add current member
  void addExistedMemberIntoCircleComponent() {
    widget.existedMembers?.forEach((eixstedMember) {
      widget.selectedMembers?.add(eixstedMember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width * 0.85,
            color: Colors.blue.shade200,
            child: listViewSelectedMember(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              if ((widget.selectedMembers?.length ?? 0) > 2) {
                widget.onSave();
              } else {
                WidgetRef.showToasted("please select new member", false);
              }
            },
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.save,
                  size: 35,
                ),
                Text("save")
              ],
            ),
          ),
        ),
      ],
    );
  }

  // listview selected members
  Widget listViewSelectedMember() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.selectedMembers?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return item(widget.selectedMembers?[index]);
        });
  }

  //
  Widget item(ConContact? selectedContact) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ComponentCircleMember(
        displayName: selectedContact?.displayName ?? "",
      ),
    );
  }
}

class ListAvailableContact extends StatefulWidget {
  final Function
      onSelectecContact; //trigger when to add/remove contact as member on the circle compoennt
  final List<ConContact?>? existedMembers;
  final List<Contact>? contacts;

  ListAvailableContact(
      {Key? key,
      this.existedMembers,
      required this.onSelectecContact,
      required this.contacts})
      : super(key: key);

  @override
  State<ListAvailableContact> createState() => _ListAvailableContactState();
}

class _ListAvailableContactState extends State<ListAvailableContact> {
  List<bool> _selected =
      List.generate(20, (i) => false); // initially fill it up with false

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.75,
        child: listViewBuilder());
  }

  Widget listViewBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Contact? contact = widget.contacts?.elementAt(index);

          return Container(
            color: _selected[index] ? Colors.green.shade300 : null,
            child: ListTile(
              subtitle: Text(contact?.phones?.first.value ?? ""),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
              leading: (contact?.avatar != null &&
                      (contact?.avatar?.isNotEmpty ?? false))
                  ? CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    )
                  : CircleAvatar(
                      child: Text(contact?.initials() ?? ""),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
              title: Text(contact?.displayName ?? ''),
              //This can be further expanded to showing contacts detail
              // onPressed().
              onTap: () {
                setState(() {
                  _selected[index] = !_selected[index];

                  //add contact/remove
                  _selected[index]
                      ? widget.onSelectecContact(
                          true, //add contact from top list
                          new ConContact(
                            contactID: DB.generateId(),
                            displayName: contact?.displayName,
                            givenName: contact?.givenName,
                            middleName: contact?.middleName,
                            phone: contact?.phones!.first.value,
                            createdDate: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            createdBy: StringRef.user,
                          ))
                      : widget.onSelectecContact(
                          false, //remove contact from top list
                          new ConContact(
                            phone: contact?.phones!.first.value,
                          ));
                });
              },
            ),
          );
        });
  }
}
