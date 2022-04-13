import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';
import 'package:sms_alert/ui/BottomNavBar.dart';
import 'package:sms_alert/ui/message/Policy/config/configMembers/listMember/PolicyConMemberView.dart';
import 'package:sms_alert/ui/message/Policy/config/configMessage/PolicyConMessageMenuView.dart';
import 'package:sms_alert/ui/message/Policy/config/configNotification/PolicyConNotificationMenuView.dart';
import 'package:sms_alert/ui/message/Policy/config/configWord/listWord/PolicyConWordView.dart';
import 'package:sms_alert/utils/widgets.dart';

class PolicyConViewMenuContentUI extends StatefulWidget {
  final String policyID;

  PolicyConViewMenuContentUI({Key? key, required this.policyID})
      : super(key: key);

  @override
  _PolicyConMenuViewContentUIState createState() =>
      _PolicyConMenuViewContentUIState();
}

class _PolicyConMenuViewContentUIState
    extends State<PolicyConViewMenuContentUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Card(
              child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text('notification configuration'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PolicyConNotificationMenuView(
                            policyID: widget.policyID,
                          )));
            },
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Filter Word Configuration'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PolicyConWordView(
                            policyID: widget.policyID,
                          )));
            },
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.perm_contact_calendar),
            title: Text('Members Configuration'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PolicyConMemberView(
                            policyID: widget.policyID,
                          )));
            },
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.sms),
            title: Text('Message Configuration'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PolicyConMessageMenuView(
                            policyID: widget.policyID,
                          )));
            },
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.remove_circle_rounded),
            title: Text('Delete Policy'),
            trailing: Icon(Icons.more_vert),
            onTap: () async {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.QUESTION,
                animType: AnimType.BOTTOMSLIDE,
                body: Text("Are you sure want to delete this policy"),
                desc: 'Are you sure you want to delete this policy?',
                dismissOnTouchOutside: false,
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  await PolicyRepository.deletePolicy(widget.policyID)
                      .then((isSuccessDelete) {
                    if (isSuccessDelete) {
                      WidgetRef.showToasted("Success Delete Policy", true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      WidgetRef.showToasted(
                          "Failed Delete Policy,try again..", false);
                    }
                  });
                },
              ).show();
            },
          )),
        ],
      ),
    );
  }
}
