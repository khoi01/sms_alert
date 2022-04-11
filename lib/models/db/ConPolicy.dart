

import 'dart:convert';

import 'package:sms_alert/models/db/Model.dart';

class ConPolicy extends Model {
  
    static String table = "Con_Policy";


  String? policyID;
  String? policyName;
  String? description;
  int? status;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  int? containNewMessage;
  String? notificationId;
  int? enableNotification;

  ConPolicy({
    this.policyID,
    this.policyName,
    this.description,
    this.status,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.containNewMessage,
    this.notificationId,
    this.enableNotification,
  });

  ConPolicy copyWith({
    String? policyID,
    String? policyName,
    String? description,
    int? status,
    String? createdDate,
    String? createdBy,
    String? modifiedDate,
    String? modifiedBy,
    int? containNewMessage,
    String? notificationId,
    int? enableNotification,
  }) {
    return ConPolicy(
      policyID: policyID ?? this.policyID,
      policyName: policyName ?? this.policyName,
      description: description ?? this.description,
      status: status ?? this.status,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      containNewMessage: containNewMessage ?? this.containNewMessage,
      notificationId: notificationId ?? this.notificationId,
      enableNotification: enableNotification ?? this.enableNotification,
    );
  }

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
      'containNewMessage': containNewMessage,
      'notificationId': notificationId,
      'enableNotification': enableNotification,
    };
  }

  factory ConPolicy.fromMap(Map<String, dynamic> map) {
    return ConPolicy(
      policyID: map['policyID'],
      policyName: map['policyName'],
      description: map['description'],
      status: map['status']?.toInt(),
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
      containNewMessage: map['containNewMessage']?.toInt(),
      notificationId: map['notificationId'],
      enableNotification: map['enableNotification']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConPolicy.fromJson(String source) => ConPolicy.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConPolicy(policyID: $policyID, policyName: $policyName, description: $description, status: $status, createdDate: $createdDate, createdBy: $createdBy, modifiedDate: $modifiedDate, modifiedBy: $modifiedBy, containNewMessage: $containNewMessage, notificationId: $notificationId, enableNotification: $enableNotification)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ConPolicy &&
      other.policyID == policyID &&
      other.policyName == policyName &&
      other.description == description &&
      other.status == status &&
      other.createdDate == createdDate &&
      other.createdBy == createdBy &&
      other.modifiedDate == modifiedDate &&
      other.modifiedBy == modifiedBy &&
      other.containNewMessage == containNewMessage &&
      other.notificationId == notificationId &&
      other.enableNotification == enableNotification;
  }

  @override
  int get hashCode {
    return policyID.hashCode ^
      policyName.hashCode ^
      description.hashCode ^
      status.hashCode ^
      createdDate.hashCode ^
      createdBy.hashCode ^
      modifiedDate.hashCode ^
      modifiedBy.hashCode ^
      containNewMessage.hashCode ^
      notificationId.hashCode ^
      enableNotification.hashCode;
  }
}
