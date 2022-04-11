import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/models/db/PolicyMsg.dart';
import 'package:sms_alert/models/db/PolicyMsgDetail.dart';
import 'package:sms_alert/models/db/PolicyMsgWord.dart';
import 'package:sms_alert/utils/db.dart';

class PolicyRepository {
  static Future<bool> updateEnableNotificationByID(
      String? policyID, bool? isEnableNotification) async {
    int result = await DB.db()!.rawUpdate(
        'UPDATE ${ConPolicy.table} SET enableNotification = ? WHERE policyID = ?',
        [(isEnableNotification ?? true) ? 1 : 0, policyID]);

    return result == 1 ? true : false;
  }

  //if new message receive,then update how many msg receice
  static Future<bool> updateContainNewMessageByPolicyID(
      String? policyID) async {
    //get existed policy information
    ConPolicy? policy = await getPolicyById(policyID);

    //get current value for containNewMessage
    int containNewMessage = policy?.containNewMessage ?? 0;
    //increase by 1,
    containNewMessage++;

    int result = await DB.db()!.rawUpdate(
        'UPDATE ${ConPolicy.table} SET containNewMessage = ? WHERE policyID = ?',
        [containNewMessage, policyID]);

    return result == 1 ? true : false;
  }

  static Future<bool> openPolicyByPolicyID(String? policyID) async {
    int result = await DB.db()!.rawUpdate(
        'UPDATE ${ConPolicy.table} SET containNewMessage = ? WHERE policyID = ?',
        [0, policyID]);

    return result == 1 ? true : false;
  }

  static Future<bool> deleteAllMessageByPolicyID(String? policyID) async {
    /* NOTE THIS FUNCTION NOT TEST PROPERLY,PLEASE CHECK AGAIN LATER*/

    await DB
        .db()!
        .delete(PolicyMsg.table, where: 'policyID = ?', whereArgs: [policyID]);

    await DB.db()!.delete(PolicyMsgDetail.table,
        where: 'policyID = ?', whereArgs: [policyID]);

    await DB.db()!.delete(PolicyMsgWord.table,
        where: 'policyID = ?', whereArgs: [policyID]);

    return true;
  }

  static Future<bool> deletePolicy(String? policyID) async {
    int isDeletePolicy = await DB
        .db()!
        .delete(ConPolicy.table, where: 'policyID = ?', whereArgs: [policyID]);

    await DB
        .db()!
        .delete(PolicyMsg.table, where: 'policyID = ?', whereArgs: [policyID]);

    await DB.db()!.delete(PolicyMsgDetail.table,
        where: 'policyID = ?', whereArgs: [policyID]);

    await DB.db()!.delete(PolicyMsgWord.table,
        where: 'policyID = ?', whereArgs: [policyID]);

    return isDeletePolicy == 1 ? true : false;
  }

  static Future<ConPolicy?> getPolicyByName(String policyName) async {
    List<Map> maps = await DB.db()!.query(ConPolicy.table,
        where: 'policyName = ?', whereArgs: [policyName]);

    if (maps.length > 0) {
      return ConPolicy.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  static Future<ConPolicy?> getPolicyById(String? policyID) async {
    List<Map> maps = await DB
        .db()!
        .query(ConPolicy.table, where: 'policyID = ?', whereArgs: [policyID]);

    if (maps.length > 0) {
      return ConPolicy.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
