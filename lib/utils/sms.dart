import 'dart:io' show Platform;
// import 'package:sms/sms.dart';
import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/models/db/ConPolicy.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/models/db/PolicyMsg.dart';
import 'package:sms_alert/models/db/PolicyMsgDetail.dart';
import 'package:sms_alert/models/db/PolicyMsgWord.dart';
import 'package:sms_alert/repository/ContactMapPolicyRepository.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';

import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/repository/WordMapPolicyRepository.dart';
import 'package:sms_alert/utils/Util.dart';
import 'package:sms_alert/utils/db.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:telephony/telephony.dart';

class SMS {
  static void initReceiver() {
    if (Platform.isAndroid) {
      receiver();
    } else if (Platform.isIOS) {}
  }

  static backgrounMessageHandler(SmsMessage message) async {
    // DB.reinit();
    //Handle background message
    MSG.initMsg(message.address ?? "", message.body ?? "");
  }

  static void receiver() {
    // This will not work as the instance will be replaced by
    // the one in background.
    final telephony = Telephony.instance;

    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          // await DB.reinit();
          MSG.initMsg(message.address ?? "", message.body ?? "");
        },
        onBackgroundMessage: backgrounMessageHandler);
  }
}

class MSG {
  static void initMsg(String sender, String message) async {
    await DB.init();
    //Get existed policy
    List<Map<String, dynamic>> results =
        await Repository.query(ConPolicy.table);
    List<ConPolicy?> policies =
        results.map((item) => ConPolicy.fromMap(item)).toList();
    List<ConContact>? members;
    List<ConWord>? words;

    policies.forEach((policy) async {
      //get all member by policy
      members = (await ContactMapPolicyRepository.getMembersByPolicyID(
              policy!.policyID))
          ?.cast<ConContact>();
      //get all word by policy
      words =
          (await WordMapPolicyRepository.getWordsByPolicyID(policy.policyID))
              ?.cast<ConWord>();

      members?.forEach((member) async {
        String? phoneModified =
            member.phone?.replaceAll(new RegExp(r"\s+\b|\b\s|\)|\(|\-"), "");
        print("phonemodified:$phoneModified sender:$sender ");

        if (phoneModified == sender && words != null) {
          if (isContainAnyWordFilter(message.split(' '), words!)) {
            //show/notify user via notification
            AppNotification.showNotication(policy, message);

            //update new message arrived
            await PolicyRepository.updateContainNewMessageByPolicyID(
                policy.policyID);

            var msgId = DB.generateId();

            PolicyMsg policyMsg = new PolicyMsg(
                msgID: msgId,
                contactID: member.contactID,
                policyID: policy.policyID,
                createdDate: DateTime.now().millisecondsSinceEpoch.toString(),
                createdBy: StringRef.system,
                source: AppMsgSource.sms);

            PolicyMsgDetail policyMsgDetail = new PolicyMsgDetail(
                msgID: msgId, message: message, policyID: policy.policyID);

            List<PolicyMsgWord> conWords = [];

            words?.forEach((word) {
              PolicyMsgWord policyMsgWord = new PolicyMsgWord(
                  msgID: msgId, wordID: word.wordID, policyID: policy.policyID);

              conWords.add(policyMsgWord);
            });

            await _save(policyMsg, policyMsgDetail, conWords).then((result) {
              if (result.isSucess) {
                print("[SMS Service]: ${result.message}");
              } else {
                print("[SMS Service]: ${result.message}");
              }
            });
          }
        }
      });
    });
  }

  // need to have at least one word then its will save msg to database
  static bool isContainAnyWordFilter(
      List<String> message, List<ConWord> words) {
    bool isContainAnyWordFilter = false;

    message.forEach((text) {
      words.forEach((word) {
        if (text.toLowerCase() == word.word?.toLowerCase()) {
          isContainAnyWordFilter = true;
        }
      });
    });

    return isContainAnyWordFilter;
  }

  //need to have all words then its will save msg to database
  static bool isContainAllWordFilter(
      List<String> message, List<ConWord> words) {
    bool isContainAllWordFilter = true;
    int totalOfWordNeedToContain = words.length;
    int totalWordAvailable = 0;

    message.forEach((text) {
      words.forEach((word) {
        if (text.toLowerCase() == word.word?.toLowerCase()) {
          totalWordAvailable++;
        }
      });
    });

    if (totalWordAvailable < totalOfWordNeedToContain) {
      isContainAllWordFilter = false;
    }

    return isContainAllWordFilter;
  }

  static Future<DBResult> _save(
      PolicyMsg policyMsg,
      PolicyMsgDetail policyMsgDetail,
      List<PolicyMsgWord> policyMsgWord) async {
    DBResult dbResult = DBResult(true, DBResult.saveMsg);

    try {
      dynamic result = await Repository.insert(PolicyMsg.table, policyMsg);
      print("[PolicyMsg]Create :$result");

      dynamic result1 =
          await Repository.insert(PolicyMsgDetail.table, policyMsgDetail);
      print("[PolicyMsgDetail]Create :$result1");

      policyMsgWord.forEach((word) async {
        dynamic result2 = await Repository.insert(PolicyMsgWord.table, word);
        print("[PolicyMsgWord]Create :$result2");
      });
    } catch (ex) {
      dbResult.isSucess = false;
      dbResult.message = ex.toString();
      print("SMS Service: $ex");
    }

    return dbResult;
  }
}
