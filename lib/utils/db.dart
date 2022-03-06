
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'package:sms_alert/models/db/ConContactMapPolicy.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/models/db/ConWordMapPolicy.dart';
import 'package:sms_alert/models/db/PolicyMsg.dart';
import 'package:sms_alert/models/db/PolicyMsgDetail.dart';
import 'package:sms_alert/models/db/PolicyMsgWord.dart';
import 'package:sms_alert/models/db/SysAppSettings.dart';
import 'package:sms_alert/models/db/SysMenu.dart';
import 'package:sms_alert/models/db/SysUser.dart';

abstract class DB{
  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async{
    if(_db != null){return;}

    try{
      String _path = await getDatabasesPath()+"smsAlertDB";
      _db = await openDatabase(_path,version:_version,onCreate: onCreate);

    }catch(ex){
      print(ex);
    }
  }
  
  static Database? db(){
		return _db;
	}

  //generate id
  static String generateId(){
    var uuid = Uuid();
    return uuid.v1();
  }

  static void onCreate(Database db, int version) async{
    print("Database:Initialize Table..");
    print("Database: Version $_version");

    print("1.Database: Table ${SysAppSettings.table} created..");
		await db.execute
    (
      '''CREATE TABLE ${SysAppSettings.table} 
    (id TEXT PRIMARY KEY NOT NULL,
     name TEXT
     )'''
     );

    print("2.Database: Table ${SysMenu.table} created..");
    await db.execute(
      '''CREATE TABLE ${SysMenu.table}
      (menuID TEXT PRIMARY KEY NOT NULL,
      menuName TEXT,
      description TEXT,
      status INTEGER,
      package TEXT
      )'''
    );

    print("3.Database: Table ${SysUser.table} created..");
    await db.execute(
      ''' CREATE TABLE ${SysUser.table}
      (name TEXT,
      email TEXT,
      password TEXT
      )'''
    );

    print("4.Database: Table ${ConPolicy.table} created..");
    await db.execute(
      ''' CREATE TABLE ${ConPolicy.table}
      (policyID TEXT PRIMARY KEY NOT NULL,
      policyName TEXT,
      description TEXT,
      status INTEGER,
      createdDate TEXT,
      createdBy TEXT,
      modifiedDate TEXT,
      modifiedBy TEXT
      )'''
    );

    print("5.Database: Table ${ConWord.table} created..");
    await db.execute(
      ''' CREATE TABLE ${ConWord.table}
      (wordID TEXT PRIMARY KEY NOT NULL,
      word TEXT,
      status INTEGER,
      createdDate TEXT,
      createdBy TEXT,
      modifiedDate TEXT,
      modifiedBy TEXT
      )'''
    );

    print("6.Database: Table ${ConContactMapPolicy.table} created..");
    await db.execute(
      ''' CREATE TABLE ${ConContactMapPolicy.table}
      (contactID TEXT NOT NULL,
      policyID TEXT NOT NULL,
      createdDate TEXT,
      createdBy TEXT,
      modifiedDate TEXT,
      modifiedBy TEXT,
      PRIMARY KEY (contactID, policyID)
      )'''
    );

    print("7.Database: Table ${ConWordMapPolicy.table} created..");
    await db.execute(
      ''' CREATE TABLE ${ConWordMapPolicy.table}
      (wordID TEXT NOT NULL,
      policyID TEXT NOT NULL,
      createdDate TEXT,
      createdBy TEXT,
      modifiedDate TEXT,
      modifiedBy Text,
      PRIMARY KEY (wordID,policyID)
      )'''
    );

    print("8.Database: Table ${PolicyMsg.table} created..");
    await db.execute(
      ''' CREATE TABLE ${PolicyMsg.table}
      (msgID TEXT NOT NULL,
      contactID TEXT NOT NULL,
      policyID TEXT NOT NULL,
      createdDate TEXT,
      createdBy TEXT,
      modifiedDate TEXT,
      modifiedBy Text,
      PRIMARY KEY(msgID , contactID, policyID)
      )'''
    );

    print("9.Database: Table ${PolicyMsgDetail.table} created..");
    await db.execute(
      ''' CREATE TABLE ${PolicyMsgDetail.table}
      (msgID TEXT PRIMARY KEY NOT NULL,
      message TEXT
      )'''
    );

    print("10.Database: Table ${PolicyMsgWord.table} created..");
    await db.execute(
      ''' CREATE TABLE ${PolicyMsgWord.table}
      (msgID TEXT NOT NULL,
      wordID TEXT NOT NULL,
      PRIMARY KEY(msgID , wordID)
      )'''
    );

    print("11.Database: Table ${ConContact.table} created..");
    await db.execute(
      ''' CREATE TABLE ${ConContact.table}
      (contactID TEXT PRIMARY KEY NOT NULL,
      displayName TEXT,
      givenName TEXT,
      middleName TEXT,
      phone TEXT,
      createdDate TEXT,
      createdBy TEXT,
      modifiedDate TEXT,
      modifiedBy TEXT
      )'''
    );
  } 
  
}

class DBResult {
  bool isSucess;
  String message;
  
  static String saveMsg = "Data saved..";


  DBResult(
    this.isSucess,
    this.message,
  );

  Map<String, dynamic> toMap() {
    return {
      'isSucess': isSucess,
      'message': message,
    };
  }

  static DBResult? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return DBResult(
      map['isSucess'],
      map['message'],
    );
  }
}


