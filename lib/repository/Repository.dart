
import 'package:sms_alert/models/db/Model.dart';
import 'package:sms_alert/utils/db.dart';

class Repository{
   static Future<int> insert(String table, Model model) async =>
      await DB.db()!.insert(table, model.toMap());

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      DB.db()!.query(table);


}