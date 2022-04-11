

import 'dart:convert';

import 'package:sms_alert/models/db/Model.dart';

class PolicyMsgWord extends Model {
  static String table = "Policy_Msg_Word";

  String?  msgID;
  String? wordID;
  String? policyID;
  PolicyMsgWord({
    this.msgID,
    this.wordID,
    this.policyID,
  });


  PolicyMsgWord copyWith({
    String? msgID,
    String? wordID,
    String? policyID,
  }) {
    return PolicyMsgWord(
      msgID: msgID ?? this.msgID,
      wordID: wordID ?? this.wordID,
      policyID: policyID ?? this.policyID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msgID': msgID,
      'wordID': wordID,
      'policyID': policyID,
    };
  }

  factory PolicyMsgWord.fromMap(Map<String, dynamic> map) {
    return PolicyMsgWord(
      msgID: map['msgID'],
      wordID: map['wordID'],
      policyID: map['policyID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyMsgWord.fromJson(String source) => PolicyMsgWord.fromMap(json.decode(source));

  @override
  String toString() => 'PolicyMsgWord(msgID: $msgID, wordID: $wordID, policyID: $policyID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PolicyMsgWord &&
      other.msgID == msgID &&
      other.wordID == wordID &&
      other.policyID == policyID;
  }

  @override
  int get hashCode => msgID.hashCode ^ wordID.hashCode ^ policyID.hashCode;
}
