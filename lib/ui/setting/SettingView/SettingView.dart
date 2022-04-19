import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:sms_alert/ui/setting/SettingPermissionView/SettingPermissionView.dart';
import 'package:sms_alert/utils/Util.dart';
import 'package:sms_alert/utils/strings.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool _isShowProgress = true;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(StringRef.appTitle),
          backgroundColor: Colors.white10,
          actions: <Widget>[],
        ),
        body: ListView(
          children: [
            // InkWell(
            //   onTap: () {
            //     // AppUrlLauncher.launchURL(AppUrlLauncher.aboutThisApp);
            //   },
            //   child: Card(
            //     child: ListTile(
            //       leading: Icon(
            //         Icons.info,
            //       ),
            //       title: Text('About This App'),
            //       trailing: Icon(Icons.more_vert),
            //     ),
            //   ),
            // ),
            // InkWell(
            //   onTap: () {
            //     // AppUrlLauncher.launchURL(AppUrlLauncher.guideApp);
            //   },
            //   child: Card(
            //     child: ListTile(
            //       leading: Icon(
            //         Icons.directions,
            //       ),
            //       title: Text('Guide'),
            //       trailing: Icon(Icons.more_vert),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingPermissionView()));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.lock_clock_rounded,
                  ),
                  title: Text('App Permission Control'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(AppImages.appIcon)),
            ),
            Center(
                child: Text(
              "SMS Filter Alert",
              style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold),
            )),
            _isShowProgress
                ? Text("")
                : Center(child: Text('Version ${_packageInfo.version}')),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
            "This application allows filtering SMS that user want to read and focus on",
            style:
                  TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.black),
          ),
                ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Application Features:",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
            child: Text(
              "1. filtering SMS by certain keywords.",
              style:
                  TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
            child: Text(
              "2. Notification Feature",
              style:
                  TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
            child: Text(
              "3. Group contact number (policy)",
              style:
                  TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
            child: Text(
              "4. Easy to use",
              style:
                  TextStyle(fontSize: 15, letterSpacing: 1, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(3, 30, 8, 9),
            child: Text(
              "NOTE: This application does not collect contacts and SMS from the user.",
              style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
                
          ],
        ));
  }

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      _isShowProgress = false;
      print(_packageInfo.version);
    });
  }
}
