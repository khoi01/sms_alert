import 'package:flutter/material.dart';
import 'package:sms_alert/repository/SysAppSettingsRepository.dart';
import 'package:sms_alert/ui/BottomNavBar.dart';
import 'package:sms_alert/ui/permissionInfo/PermissionInfoView.dart';
import 'package:sms_alert/utils/Util.dart';
import 'package:sms_alert/utils/db.dart';

//https://github.com/FlutterOpen/flutter-widgets
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Init DB here
  await DB.init();
  // SMS.initReceiver();
  runApp(SmsAlertApp());
}

class SmsAlertApp extends StatefulWidget {
  const SmsAlertApp({Key? key}) : super(key: key);

  @override
  State<SmsAlertApp> createState() => _SmsAlertAppState();
}

class _SmsAlertAppState extends State<SmsAlertApp> {
  late MaterialApp _app;
  bool _isShowProgress = true;

  @override
  void initState() {
    super.initState();

    begin().then((app) {
      setState(() {
        _app = app;
        _isShowProgress = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //init notification
    AppNotification.init(context);
    return _isShowProgress
        ? Container(
            color: Colors.green,
          )
        : _app;
  }

  Future<MaterialApp> begin() async {
    bool? isFirstTimeLogin = await SysAppSettingsRepository.isFirstTimeLogin();

    if (isFirstTimeLogin ?? true) {
      return MaterialApp(title: 'Material App', home: PermissionInfo());
    } else {
      return MaterialApp(title: 'Material App', home: BottomNavBar());
    }
  }
}
