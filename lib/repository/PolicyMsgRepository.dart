import 'package:sms_alert/models/db/PolicyMsg.dart';
import 'package:sms_alert/models/db/PolicyMsgDetail.dart';
import 'package:sms_alert/models/db/PolicyMsgWord.dart';
import 'package:sms_alert/models/model/Policy.dart';
import 'package:sms_alert/utils/db.dart';

class PolicyMsgRepository{
  static Future<List<Policy>?> getPoliciesMsgByPolicyID(String? policyID) async{
    
    List<Policy> policies = [];
    


    List<Map> policyMsgs = await DB.db()!.query(
      PolicyMsg.table,
      where: 'policyID = ?',
      whereArgs:[policyID]
    );

    List<PolicyMsg?> policiesMsg = policyMsgs.map((item) => PolicyMsg.fromMap(item as Map<String, dynamic>)).toList();
    
    policiesMsg.forEach((policyMsg) {
        Policy policy = new Policy();
        policy.setPolicyMsg(policyMsg);
        policies.add(policy);
     });

    await Future.forEach(policies, (dynamic policy) async {
      
      List<Map> policyMsgDetails = await DB.db()!.query(
        PolicyMsgDetail.table,
        where: 'msgID = ?',
        whereArgs: [policy.policyMsg.msgID]
      );
      
      if(policyMsgDetails.length>0){
        policy.setPolicyMsgDetail(PolicyMsgDetail.fromMap(policyMsgDetails.first as Map<String, dynamic>));
      }
            
    });


    await Future.forEach(policies,(dynamic policy) async { 
      List<Map> policyMsgWords = await DB.db()!.query(
        PolicyMsgWord.table,
        where: 'msgID = ?',
        whereArgs: [policy.policyMsg.msgID]
      );

      List<PolicyMsgWord?> policiesMsgWord = policyMsgWords.map((item) => PolicyMsgWord.fromMap(item as Map<String, dynamic>)).toList(); 

      if(policiesMsgWord.length>0){

        policy.setPolicyMsgWord(policiesMsgWord);
      }

    });

      if(policies.length>0){
        return policies;
      }else{
        return null;
      }

  }
}