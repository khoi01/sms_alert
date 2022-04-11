import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/models/db/ConContactMapPolicy.dart';
import 'package:sms_alert/repository/ContactRepository.dart';
import 'package:sms_alert/utils/db.dart';


class ContactMapPolicyRepository{


  //Delete single Contact inside specific policy
  static Future<bool> removeContactByPolicyIDAndContactID(String? policyID,String? contactID) async {
    
    int isDelete = await DB.db()!.delete(ConContactMapPolicy.table,
    where: 'policyID = ? and contactID = ?',
    whereArgs: [policyID,contactID]);

    return isDelete == 1 ? true : false;

  }

  static Future<List<ConContact?>?> getMembersByPolicyID(String? policyID) async{
    List<ConContact?> members = [];

    List<Map<String,dynamic>> result = await DB.db()!.query(
      ConContactMapPolicy.table,
      where: 'policyID = ?',
      whereArgs: [policyID]
    );


    List<ConContactMapPolicy?> conContactMapPolicy = result.map((item) => ConContactMapPolicy.fromMap(item)).toList();

    await Future.forEach(conContactMapPolicy, (dynamic item) async {
      ConContact? member = await ContactRepository.getContactByContactID(item.contactID);

      members.add(member);
    });

    if(members.length>0){
      return members;
    }else{
      return null;
    }
  }
}