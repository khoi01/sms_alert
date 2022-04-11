


import 'package:sms_alert/models/db/Model.dart';

class ConWord extends Model {

    static String table = "Con_Word";

  String? wordID;
  String? word;
  int? status;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  ConWord({
    this.wordID,
    this.word,
    this.status,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'wordID': wordID,
      'word': word,
      'status': status,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'modifiedDate': modifiedDate,
      'modifiedBy': modifiedBy,
    };
  }

  static ConWord? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
  
    return ConWord(
      wordID: map['wordID'],
      word: map['word'],
      status: map['status'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
      modifiedDate: map['modifiedDate'],
      modifiedBy: map['modifiedBy'],
    );
  }

  @override
  String toString() {
    return super.toString();
  }
}
