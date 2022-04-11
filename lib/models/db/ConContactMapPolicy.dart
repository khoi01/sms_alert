
import 'package:sms_alert/models/db/Model.dart';

class ConContactMapPolicy extends Model {

  static String table = "Con_Contact_Map_Policy";

  String? contactID;
  String? policyID;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;

  ConContactMapPolicy({
    this.contactID,
    this.policyID,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'contactID': contactID,
      'policyID': policyID,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
    };
  }

  static ConContactMapPolicy? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
  
    return ConContactMapPolicy(
      contactID: map['contactID'],
      policyID: map['policyID'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
    );
  }
}
