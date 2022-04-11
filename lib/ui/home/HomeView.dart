import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/ui/home/HomeViewContent.dart';
import 'package:sms_alert/ui/policy/SelectPhone/PolicyPhoneView.dart';
import 'package:sms_alert/ui/word/WordCreateView.dart';
import 'package:sms_alert/utils/strings.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  List<ConPolicy>? _policies = [];
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

    WidgetsBinding.instance!.addObserver(this);
    getPolicies();
    initPackageInfo();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      setState(() {
        getPolicies();
        initPackageInfo();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(StringRef.appTitle),
          backgroundColor: Colors.white10,
          actions: <Widget>[
            InkWell(
                onTap: () {
                  setState(() {
                    //refresh page
                    getPolicies();
                  });
                },
                child: Icon(Icons.refresh)),
            _simplePopup()
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 1,
              child: Align(
                  alignment: Alignment.topCenter, child: HomeViewHeaderUI()),
            ),
            Positioned.fill(
                            top: 35,

                child: Align(
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
                  _isShowProgress
                      ? CircularProgressIndicator()
                      : HomeViewContentUI(
                          policies: _policies,
                          onTriggerState: () {
                            setState(() {
                              getPolicies();
                            });
                          },
                        ),
                ],
              ),
            )
            ),
                  Positioned.fill(
                    bottom: 3,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("Version ${_packageInfo.version}")))
          ],
        ));
  }

  void getPolicies() async {
    // List<Map<String, dynamic>> results =
    await Repository.query(ConPolicy.table).then((results) {
      setState(() {
        _policies = results
            .map((item) => ConPolicy.fromMap(item))
            .cast<ConPolicy>()
            .toList();

          _policies?.sort((a, b) => -int.parse(a.createdDate ?? '0')
              .compareTo(int.parse(b.createdDate ?? '0')));
      });
    });
  }

  Future<void> initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      _isShowProgress = false;
      print(_packageInfo.version);
    });
  }

//menu pop
  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(StringRef.createPolicyTitle),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(StringRef.createFilterTitle),
          ),
        ],
        onSelected: (navigationID) async {
          if (navigationID == 1) {
            await Permission.contacts.request().isGranted.then((response) {
              if (response) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PolicyPhoneView()));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                          title: Text('Permissions error'),
                          content: Text('Please enable contacts access '
                              'permission in system settings'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        ));
              }
            });
          } else if (navigationID == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (content) => WordCreateView()));
          }
        },
      );
}
