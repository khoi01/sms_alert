

import 'package:sms_alert/models/db/Model.dart';

class PolicyMsg extends Model {

  static String table = "Policy_Msg";

  String msgID;
  String contactID;
  String policyID;
  String createdDate;
  String createdBy;
  String modifiedDate;
  String modifiedBy;
  PolicyMsg({
    this.msgID,
    this.contactID,
    this.policyID,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });


  Map<String, dynamic> toMap() {
    return {
      'msgID': msgID,
      'contactID': contactID,
      'policyID': policyID,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
    };
  }

  static PolicyMsg fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PolicyMsg(
      msgID: map['msgID'],
      contactID: map['contactID'],
      policyID: map['policyID'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
    );
  }
}
