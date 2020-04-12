import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/utils/db.dart';

class PolicyRepository{

    static Future<ConPolicy> getPolicyByName(String policyName) async{
      List<Map> maps = await DB.db().query(
        ConPolicy.table,
        where: 'policyName = ?', 
        whereArgs: [policyName]
      );
  
      if(maps.length > 0){
        return ConPolicy.fromMap(maps.first);
      }else{
        return null;
      }
    }

    static Future<ConPolicy> getPolicyById(String policyID) async{
      List<Map> maps = await DB.db().query(
        ConPolicy.table,
        where: 'policyID = ?',
        whereArgs: [policyID]
      );

      if(maps.length > 0){
        return ConPolicy.fromMap(maps.first);
      }else{
        return null;
      }
    }
}