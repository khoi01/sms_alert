import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/utils/db.dart';

class WordRepository{
  static Future<ConWord?> getWordByName(String word) async{
    List<Map> maps = await DB.db()!.query(
      ConWord.table,
      where: 'word = ?',
      whereArgs: [word]
    );

    if(maps.length > 0){
      return ConWord.fromMap(maps.first as Map<String, dynamic>);
    }else{
      return null;
    }
  }

  static Future<ConWord?> getWordByWordID(String? wordID) async{
    
    List<Map> maps = await DB.db()!.query(
      ConWord.table,
      where: 'wordID = ?',
      whereArgs: [wordID]
    );

    if(maps.length > 0){
      return ConWord.fromMap(maps.first as Map<String, dynamic>);
    }else{
      return null;
    }
  }


}