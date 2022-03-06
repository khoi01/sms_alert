

import 'package:sms_alert/models/db/Model.dart';

class PolicyMsgWord extends Model {
  static String table = "Tran_Msg_Word";

  String?  msgID;
  String? wordID;
  PolicyMsgWord({
    this.msgID,
    this.wordID,
  });

  Map<String, dynamic> toMap() {
    return {
      'msgID': msgID,
      'wordID': wordID,
    };
  }

  static PolicyMsgWord? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PolicyMsgWord(
      msgID: map['msgID'],
      wordID: map['wordID'],
    );
  }
}
