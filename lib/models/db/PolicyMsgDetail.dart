import 'dart:convert';

import 'package:sms_alert/models/db/Model.dart';

class PolicyMsgDetail extends Model {
  static String table = "Policy_Msg_Detail";

  String? msgID;
  String? message;
  String? policyID;
  
  PolicyMsgDetail({
    this.msgID,
    this.message,
    this.policyID,
  });

  PolicyMsgDetail copyWith({
    String? msgID,
    String? message,
    String? policyID,
  }) {
    return PolicyMsgDetail(
      msgID: msgID ?? this.msgID,
      message: message ?? this.message,
      policyID: policyID ?? this.policyID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msgID': msgID,
      'message': message,
      'policyID': policyID,
    };
  }

  factory PolicyMsgDetail.fromMap(Map<String, dynamic> map) {
    return PolicyMsgDetail(
      msgID: map['msgID'],
      message: map['message'],
      policyID: map['policyID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyMsgDetail.fromJson(String source) =>
      PolicyMsgDetail.fromMap(json.decode(source));

  @override
  String toString() =>
      'PolicyMsgDetail(msgID: $msgID, message: $message, policyID: $policyID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PolicyMsgDetail &&
        other.msgID == msgID &&
        other.message == message &&
        other.policyID == policyID;
  }

  @override
  int get hashCode => msgID.hashCode ^ message.hashCode ^ policyID.hashCode;
}
