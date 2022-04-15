import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
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
            InkWell(
              onTap: () {
                // AppUrlLauncher.launchURL(AppUrlLauncher.aboutThisApp);
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text('About This App'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // AppUrlLauncher.launchURL(AppUrlLauncher.guideApp);
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.directions,
                  ),
                  title: Text('Guide'),
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
                : Center(child: Text('Version ${_packageInfo.version}'))
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
