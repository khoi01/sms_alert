import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/utils/db.dart';

class ContactRepository{


  static Future<ConContact> getContactByContactID(String contactID) async{
    
    List<Map> maps = await DB.db().query(
      ConContact.table,
      where: 'contactID = ?',
      whereArgs: [contactID]
    );

    if(maps.length > 0){
      return ConContact.fromMap(maps.first);
    }else{
      return null;
    }
  }

}