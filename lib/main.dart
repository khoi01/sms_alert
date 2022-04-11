import 'package:flutter/material.dart';
import 'package:sms_alert/ui/BottomNavBar.dart';
import 'package:sms_alert/ui/home/HomeView.dart';
import 'package:sms_alert/utils/Util.dart';
import 'package:sms_alert/utils/db.dart';
import 'package:sms_alert/utils/sms.dart';


//https://github.com/FlutterOpen/flutter-widgets
 void main() async{
	WidgetsFlutterBinding.ensureInitialized();

    //Init DB here
      await DB.init();
      SMS.initReceiver();
  	runApp(SmsAlertApp());
 }

class SmsAlertApp extends StatelessWidget {
  const SmsAlertApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      //init notification 
  AppNotification.init(context);
  
    return MaterialApp(
      title: 'Material App',
      home: BottomNavBar()
    );
  }
} 