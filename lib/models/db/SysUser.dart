import 'package:sms_alert/models/db/Model.dart';

class SysUser extends Model {

  static String table = "Sys_User";

  String name;
  String emai;
  String password;
  SysUser({
    this.name,
    this.emai,
    this.password,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emai': emai,
      'password': password,
    };
  }

  static SysUser fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SysUser(
      name: map['name'],
      emai: map['emai'],
      password: map['password'],
    );
  }

}
