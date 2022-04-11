import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';
import 'package:sms_alert/ui/message/Policy/config/configNotification/PolicyConNotificationMenuViewContent.dart';

class PolicyConNotificationMenuView extends StatefulWidget {
  final String policyID;
  const PolicyConNotificationMenuView({Key? key, required this.policyID})
      : super(key: key);

  @override
  State<PolicyConNotificationMenuView> createState() =>
      _PolicyConMessageMenuViewState();
}

class _PolicyConMessageMenuViewState
    extends State<PolicyConNotificationMenuView> {
  ConPolicy? _conPolicy;
  bool _isShowProgress = true;

  @override
  void initState() {
    super.initState();
    getPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Configuration"),
        backgroundColor: Colors.white10,
        actions: [],
      ),
      body: _isShowProgress
          ? Center(child: CircularProgressIndicator())
          : ListView(children: <Widget>[
              PolicyConNotificationEnableDisableUI(
                enableNotification: _conPolicy?.enableNotification,
                onEnableNotification: (isEnableNotication) {
                  //update enable/disable notificaiton
                  save(isEnableNotication);
                },
              )
            ]),
    );
  }

  void getPolicy() async {
    PolicyRepository.getPolicyById(widget.policyID).then((policy) {
      setState(() {
        _conPolicy = policy;
        _isShowProgress = false;
      });
    });
  }

  Future<void> save(bool isEnableNotication) async {
    await PolicyRepository.updateEnableNotificationByID(
            widget.policyID, isEnableNotication)
        .then((response) {
          getPolicy();
        });
  }
}
