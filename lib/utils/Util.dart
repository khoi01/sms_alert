import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';

class AppUtils {
  static closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

class AppImages{
  static String appIcon = "assets/icons/icon.png";
}

class AppMsgSource {
  static String sms = "SMS";
  static String whatsapp = "WHATSAPP";
  static String email = "EMAIL";
  static String telegram = "TELEGRAM";
}

class AppNotification {
  static showNotication(ConPolicy? policy, String? msg) {

    //check if policy enable notifcation or npt
    if ((policy?.enableNotification == 1 ? true : false)) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            
              id: 10,
              channelKey: 'basic_channel',
              title: 'SMS Alert (${policy?.policyName})',
              body: msg ?? ""));
    }
  }

  static init(BuildContext context) {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    //Notification Listener
    // AwesomeNotifications()
    //     .actionStream
    //     .listen((ReceivedNotification receivedNotification) {
    //   print("====================NOTIFICATION IS WORKING!");
    //   // Navigator.of(context).pushNamed('/NotificationPage', arguments: {
    //   //   // your page params. I recommend you to pass the
    //   //   // entire *receivedNotification* object
    //   //   id: receivedNotification.id
    //   // });
    // });
  }
}
