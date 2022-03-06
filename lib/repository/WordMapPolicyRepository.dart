import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/models/db/ConWordMapPolicy.dart';
import 'package:sms_alert/repository/WordRepository.dart';
import 'package:sms_alert/utils/db.dart';

class WordMapPolicyRepository{
  static Future<List<ConWord?>?> getWordsByPolicyID(String? policyID) async{

    List<ConWord?> words = [];

    List<Map<String,dynamic>> result = await DB.db()!.query(
      ConWordMapPolicy.table,
      where: 'policyID = ?',
      whereArgs: [policyID]
    );

    List<ConWordMapPolicy?> conWordMapPolicy = result.map((item) => ConWordMapPolicy.fromMap(item)).toList();
  
    await Future.forEach(conWordMapPolicy, (dynamic item) async{
      ConWord? word = await WordRepository.getWordByWordID(item.wordID);
      words.add(word);
    });


    if(words.length>0){
      return words;
    }else{
      return null;
    }

  }
}