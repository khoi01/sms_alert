
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_alert/ui/home/HomeViewContent.dart';
import 'package:sms_alert/ui/policy/SelectPhone/PolicyPhoneView.dart';
import 'package:sms_alert/ui/word/WordCreateView.dart';
import 'package:sms_alert/utils/strings.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRef.appTitle),
        backgroundColor: Colors.white10,
        actions: <Widget>[          
          _simplePopup()          
        ],
      ),
      body: ListView(
        children: <Widget>[
          HomeViewHeaderUI(),
          HomeViewContentUI()
        ],
      ),
    );
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
              onSelected: (navigationID) async{
                if(navigationID == 1){

                  // final PermissionStatus permissionStatus = await _getPermission();
                  // if(permissionStatus == PermissionStatus.granted){
                    //navigate to another route
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PolicyPhoneView()
                      ));
                  // }else{
                  // //If permissions have been denied show standard cupertino alert dialog
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) => CupertinoAlertDialog(
                  //             title: Text('Permissions error'),
                  //             content: Text('Please enable contacts access '
                  //                 'permission in system settings'),
                  //             actions: <Widget>[
                  //               CupertinoDialogAction(
                  //                 child: Text('OK'),
                  //                 onPressed: () => Navigator.of(context).pop(),
                  //               )
                  //             ],
                  //           ));                    
                  // }
                  

                }else if(navigationID == 2){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (content) => WordCreateView()
                  ));
                }
              },
        );

  //Check contacts permission
  // Future<PermissionStatus> _getPermission() async {
  //   final PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.contacts);
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.denied/*PermissionStatus.disabled*/) {
  //     final Map<PermissionGroup, PermissionStatus> permissionStatus =
  //         await PermissionHandler()
  //             .requestPermissions([PermissionGroup.contacts]);
  //     return permissionStatus[PermissionGroup.contacts] ??
  //         PermissionStatus.unknown;
  //   } else {
  //     return permission;
  //   }
  // }
}


