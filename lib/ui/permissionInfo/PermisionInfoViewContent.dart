import 'package:flutter/material.dart';
import 'package:sms_alert/utils/Util.dart';

class PermissionInfoViewHeader extends StatelessWidget {
  const PermissionInfoViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appIcon,
              height: 60,
              width: 80,
            ),
            Text(
              "SMS Filter Alert",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 3,
                  fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionInfoViewAbout extends StatelessWidget {
  const PermissionInfoViewAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This application allows filtering SMS that user want to read and focus on",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Application Features:",
            style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "1. filtering SMS by certain keywords.",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
          Text(
            "2. Notification Feature",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
          Text(
            "3. Group contact number (policy)",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
          Text(
            "4. Easy to use",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(3, 30, 8, 9),
            child: Text(
              "Permission (IMPORTANT)",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "This application needs to be able to access your SMS and contact numbers so that this application is able to identify the contacts you need to focus on and access their SMS for filtering purposes.",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
                    Padding(
            padding: EdgeInsets.fromLTRB(3, 30, 8, 9),
            child: Text(
              "Permission Require:",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
              Text(
            "1.Contacts",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),
             Text(
            "2.SMS",
            style:
                TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.white),
          ),  Padding(
            padding: EdgeInsets.fromLTRB(3, 30, 8, 9),
            child: Text(
              "NOTE: This application does not collect contacts and SMS from the user.",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ), Padding(
            padding: EdgeInsets.fromLTRB(3, 30, 8, 9),
            child: Text(
              "By click button Continue,I understand the purpose of this app and will allow to access SMS and Contacts for filtering purpose. ",
              style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 2,
                  color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
