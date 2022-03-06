

import 'package:sms_alert/models/db/Model.dart';

class SysMenu extends Model {

  static String table = "Sys_Menu";

  String? menuID;
  String? menuName;
  String? description;
  int? status;
  String? package;

  SysMenu({
    this.menuID,
    this.menuName,
    this.description,
    this.status,
    this.package,
  });

  Map<String, dynamic> toMap() {
    return {
      'menuID': menuID,
      'menuName': menuName,
      'description': description,
      'status': status,
      'package': package,
    };
  }

  static SysMenu? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SysMenu(
      menuID: map['menuID'],
      menuName: map['menuName'],
      description: map['description'],
      status: map['status'],
      package: map['package'],
    );
  }

}
