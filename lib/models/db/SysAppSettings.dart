import 'dart:convert';

import 'package:sms_alert/models/db/Model.dart';

class SysAppSettings extends Model {
  static String table = "Sys_AppSettings";

  int? isFirstTimeLogin;
  SysAppSettings({
    this.isFirstTimeLogin,
  });

  SysAppSettings copyWith({
    int? isFirstTimeLogin,
  }) {
    return SysAppSettings(
      isFirstTimeLogin: isFirstTimeLogin ?? this.isFirstTimeLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isFirstTimeLogin': isFirstTimeLogin,
    };
  }

  factory SysAppSettings.fromMap(Map<String, dynamic> map) {
    return SysAppSettings(
      isFirstTimeLogin: map['isFirstTimeLogin']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SysAppSettings.fromJson(String source) => SysAppSettings.fromMap(json.decode(source));

  @override
  String toString() => 'SysAppSettings(isFirstTimeLogin: $isFirstTimeLogin)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SysAppSettings &&
      other.isFirstTimeLogin == isFirstTimeLogin;
  }

  @override
  int get hashCode => isFirstTimeLogin.hashCode;
}
