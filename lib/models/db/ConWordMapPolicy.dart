
import 'package:sms_alert/models/db/Model.dart';

class ConWordMapPolicy extends Model {

  static String table = "Con_Word_Map_Policy";

  String wordID;
  String policyID;
  String createdDate;
  String createdBy;
  String modifiedDate;
  String modifiedBy;
  ConWordMapPolicy({
    this.wordID,
    this.policyID,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'wordID': wordID,
      'policyID': policyID,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
    };
  }

  static ConWordMapPolicy fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ConWordMapPolicy(
      wordID: map['wordID'],
      policyID: map['policyID'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
    );
  }
}
