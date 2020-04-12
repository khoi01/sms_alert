

import 'package:sms_alert/models/db/Model.dart';

class ConContact extends Model {

  static String table = "Con_Contact";


  String contactID; 
  String displayName;
  String givenName;
  String middleName;
  String phone;
  String createdDate;
  String createdBy;
  String modifiedDate;
  String modifiedBy;

  ConContact({
    this.contactID,
    this.displayName,
    this.givenName,
    this.middleName,
    this.phone,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });
   
  
  Map<String, dynamic> toMap() {
    return {
      'contactID': contactID,
      'displayName': displayName,
      'givenName': givenName,
      'middleName': middleName,
      'phone': phone,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
    };
  }

  static ConContact fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ConContact(
      contactID: map['contactID'],
      displayName: map['displayName'],
      givenName: map['givenName'],
      middleName: map['middleName'],
      phone: map['phone'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
    );
  }
}
