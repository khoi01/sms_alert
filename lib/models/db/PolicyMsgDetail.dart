
import 'package:sms_alert/models/db/Model.dart';

class PolicyMsgDetail extends Model {
    static String table = "Tran_Msg_Detail";

    String msgID;
    String message;
  PolicyMsgDetail({
    this.msgID,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'msgID': msgID,
      'message': message,
    };
  }

  static PolicyMsgDetail fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PolicyMsgDetail(
      msgID: map['msgID'],
      message: map['message'],
    );
  }

}
