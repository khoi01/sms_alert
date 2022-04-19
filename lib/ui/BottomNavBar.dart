import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_alert/ui/home/HomeView.dart';
import 'package:sms_alert/ui/setting/SettingView/SettingView.dart';
import 'package:sms_alert/utils/sms.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  DateTime? currentBackPressTime;

  
  

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
      SMS.initReceiver();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F6),
      bottomNavigationBar: Material(
        elevation: 2.0,
        child: Container(
          height: 50.0,
          child: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 * 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getBottomNavBarItem(0, Icons.account_balance, 'POLICIES'),
                  getBottomNavBarItem(2, Icons.app_settings_alt, 'ABOUT'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: (currentIndex == 0) ? HomeView() : SettingView(),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } else {
      return true;
    }
  }

  getBottomNavBarItem(int index, icon, String text) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      focusColor: Theme.of(context).colorScheme.primary,
      onTap: () {
        changeIndex(index);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0 * 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 21.0,
              color: (currentIndex == index)
                  ? Color(0xFF60A32A)
                  : const Color(0xFF808080),
            ),
            SizedBox(height: 5.0),
            Text(
              text,
              style: (currentIndex == index)
                  ? TextStyle(
                      fontSize: 10.0,
                      color: Color(0xFF60A32A),
                    )
                  : TextStyle(
                      fontSize: 10.0,
                      color: Color(0xFF808080),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
