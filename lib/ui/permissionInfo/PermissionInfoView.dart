import 'package:flutter/material.dart';
import 'package:sms_alert/repository/SysAppSettingsRepository.dart';
import 'package:sms_alert/ui/BottomNavBar.dart';
import 'package:sms_alert/ui/permissionInfo/PermisionInfoViewContent.dart';

class PermissionInfo extends StatelessWidget {
  const PermissionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade600,
        body: ListView(shrinkWrap: true, children: <Widget>[
          PermissionInfoViewHeader(),
          PermissionInfoViewAbout(),
          TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black87,
                backgroundColor: Colors.white,
                minimumSize: Size(88, 36),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
              ),
              onPressed: () {
                SysAppSettingsRepository.setIsNotFirstTimeLoginAnymore()
                    .then((response) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                      (route) => false);
                });
              },
              child: Text("Continue.."))
        ]));
  }
}
