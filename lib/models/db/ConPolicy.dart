
import 'package:sms_alert/models/db/Model.dart';

class ConPolicy extends Model {
  
    static String table = "Con_Policy";


  String policyID;
  String policyName;
  String description;
  int status;
  String createdDate;
  String createdBy;
  String modifiedDate;
  String modifiedBy;
  ConPolicy({
    this.policyID,
    this.policyName,
    this.description,
    this.status,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });



  Map<String, dynamic> toMap() {
    return {
      'policyID': policyID,
      'policyName': policyName,
      'description': description,
      'status': status,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
    };
  }

  static ConPolicy fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ConPolicy(
      policyID: map['policyID'],
      policyName: map['policyName'],
      description: map['description'],
      status: map['status'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
    );
  }
}
