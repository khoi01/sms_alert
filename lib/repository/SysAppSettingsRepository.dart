import 'package:sms_alert/models/db/SysAppSettings.dart';
import 'package:sms_alert/utils/db.dart';

class SysAppSettingsRepository {
  static Future<bool> setIsNotFirstTimeLoginAnymore() async {
    int result = await DB.db()!.rawUpdate(
        'UPDATE ${SysAppSettings.table} SET isFirstTimeLogin = ?', [0]);

    return result == 1 ? true : false;
  }

  static Future<bool?> isFirstTimeLogin() async{

    List<Map> maps = await DB.db()!.query(
      SysAppSettings.table,
    );

    if(maps.length > 0){
      return SysAppSettings.fromMap(maps.first as Map<String,dynamic>).isFirstTimeLogin == 1 ? true : false;
    }
  }


}
