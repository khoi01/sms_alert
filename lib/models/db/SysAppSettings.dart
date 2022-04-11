import 'package:sms_alert/models/db/Model.dart';

class SysAppSettings extends Model {
  static String table = "Sys_AppSettings";

  String? name;
  String? value;

  SysAppSettings({
    this.name,
    this.value,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  static SysAppSettings? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
  
    return SysAppSettings(
      name: map['name'],
      value: map['value'],
    );
  }
}
