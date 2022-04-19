import 'package:flutter/material.dart';
import 'package:sms_alert/components/ComponentSetting.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_alert/utils/widgets.dart';

class SettingPermissionView extends StatefulWidget {
  const SettingPermissionView({Key? key}) : super(key: key);

  @override
  State<SettingPermissionView> createState() => _SettingPermissionViewState();
}

class _SettingPermissionViewState extends State<SettingPermissionView> {
  bool _isEnablePermissionSMS = false;
  bool _isEnablePermissionContacts = false;
  bool _isShowProgress = true;
  @override
  void initState() {
    super.initState();

    initPermission();
  }

  Future<void> initPermission() async {
    PermissionStatus permissionStatusContacts =
        await Permission.contacts.status;

    if (permissionStatusContacts.isGranted) {
      _isEnablePermissionContacts = true;
    }

    PermissionStatus permissionStatusSMS = await Permission.sms.status;

    if (permissionStatusSMS.isGranted) {
      _isEnablePermissionSMS = true;
    }

    setState(() {
      _isShowProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Permission Control"),
        backgroundColor: Colors.white10,
        actions: [],
      ),
      body: _isShowProgress
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(shrinkWrap: true, children: <Widget>[
              ComponentSettingFlag(
                icon: Icons.sms,
                title: "SMS",
                description:
                    "Allow this app to access your SMS for filtering and checking for the purpose of this app features. This app not collect any message from user.",
                status: _isEnablePermissionSMS,
                onClick: () async {
                  await Permission.sms.request().then((response) {
                    setState(() {
                      if (response.isGranted) {
                        WidgetRef.showToasted("Enable Permission SMS", true);
                      } else {
                        WidgetRef.showToasted("Disable Permission SMS", false);
                      }
                    });
                  });
                },
              ),
              ComponentSettingFlag(
                icon: Icons.contacts,
                title: "Contacts",
                description:
                    "Allow this app to access your contact for identify with  of your contact want to filtering and checking for the purpose of this app fetures. This app not collect any contacts from user.",
                status: _isEnablePermissionContacts,
                onClick: () async {
                  await Permission.contacts.request().then((response) {
                    setState(() {
                      if (response.isGranted) {
                        WidgetRef.showToasted(
                            "Enable Permission Contacts", true);
                      } else {
                        WidgetRef.showToasted(
                            "Disable Permission Contacts", false);
                      }
                    });
                  });
                },
              )
            ]),
    );
  }
}
