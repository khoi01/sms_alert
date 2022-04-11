

import 'dart:convert';

import 'package:sms_alert/models/db/Model.dart';

class PolicyMsg extends Model {

  static String table = "Policy_Msg";

  String? msgID;
  String? contactID;
  String? policyID;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? source;
  PolicyMsg({
    this.msgID,
    this.contactID,
    this.policyID,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.source,
  });
  

  PolicyMsg copyWith({
    String? msgID,
    String? contactID,
    String? policyID,
    String? createdDate,
    String? createdBy,
    String? modifiedDate,
    String? modifiedBy,
    String ? source,
  }) {
    return PolicyMsg(
      msgID: msgID ?? this.msgID,
      contactID: contactID ?? this.contactID,
      policyID: policyID ?? this.policyID,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msgID': msgID,
      'contactID': contactID,
      'policyID': policyID,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
      'source': source,
    };
  }

  factory PolicyMsg.fromMap(Map<String, dynamic> map) {
    return PolicyMsg(
      msgID: map['msgID'],
      contactID: map['contactID'],
      policyID: map['policyID'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
      source: map['source'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyMsg.fromJson(String source) => PolicyMsg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PolicyMsg(msgID: $msgID, contactID: $contactID, policyID: $policyID, createdDate: $createdDate, createdBy: $createdBy, modifiedDate: $modifiedDate, modifiedBy: $modifiedBy, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PolicyMsg &&
      other.msgID == msgID &&
      other.contactID == contactID &&
      other.policyID == policyID &&
      other.createdDate == createdDate &&
      other.createdBy == createdBy &&
      other.modifiedDate == modifiedDate &&
      other.modifiedBy == modifiedBy &&
      other.source == source;
  }

  @override
  int get hashCode {
    return msgID.hashCode ^
      contactID.hashCode ^
      policyID.hashCode ^
      createdDate.hashCode ^
      createdBy.hashCode ^
      modifiedDate.hashCode ^
      modifiedBy.hashCode ^
      source.hashCode;
  }
}
