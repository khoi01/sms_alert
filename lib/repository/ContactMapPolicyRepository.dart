import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/models/db/ConContactMapPolicy.dart';
import 'package:sms_alert/repository/ContactRepository.dart';
import 'package:sms_alert/utils/db.dart';


class ContactMapPolicyRepository{
  static Future<List<ConContact>> getContactsByPolicyID(String policyID) async{
    List<ConContact> members = [];

    List<Map<String,dynamic>> result = await DB.db().query(
      ConContactMapPolicy.table,
      where: 'policyID = ?',
      whereArgs: [policyID]
    );


    List<ConContactMapPolicy> conContactMapPolicy = result.map((item) => ConContactMapPolicy.fromMap(item)).toList();

    await Future.forEach(conContactMapPolicy, (item) async {
      ConContact member = await ContactRepository.getContactByContactID(item.contactID);

      members.add(member);
    });

    if(members.length>0){
      return members;
    }else{
      return null;
    }
  }
}