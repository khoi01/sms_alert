import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';
import 'package:sms_alert/ui/home/HomeView.dart';
import 'package:sms_alert/utils/widgets.dart';

class PolicyConMessageContentUI extends StatefulWidget {
  final String policyID;
  const PolicyConMessageContentUI({Key? key, required this.policyID})
      : super(key: key);

  @override
  State<PolicyConMessageContentUI> createState() =>
      _PolicyConMessageContentUIState();
}

class _PolicyConMessageContentUIState extends State<PolicyConMessageContentUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.QUESTION,
                animType: AnimType.BOTTOMSLIDE,
                body: Text(
                    "Are you sure want to delete all message inside current policy?"),
                desc:
                    'Are you sure want to delete all message inside current policy?',
                dismissOnTouchOutside: false,
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  await PolicyRepository.deleteAllMessageByPolicyID(
                          widget.policyID)
                      .then((isSuccessDelete) {
                    if (isSuccessDelete) {
                      WidgetRef.showToasted("Success delete all msg.", true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      WidgetRef.showToasted(
                          "Failed delete all msg,try again..", false);
                    }
                  });
                },
              ).show();
            },
            child: Card(
                child: ListTile(
              leading: Icon(Icons.remove_circle_outline_outlined),
              title: Text('Delete All message'),
              trailing: Icon(Icons.more_vert),
            )),
          ),
        ],
      ),
    );
  }
}
