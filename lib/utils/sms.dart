// import 'dart:io' show Platform;
// import 'package:sms/sms.dart';
// import 'package:sms_alert/models/db/ConContact.dart';
// import 'package:sms_alert/models/db/ConPolicy.dart';
// import 'package:sms_alert/models/db/ConWord.dart';
// import 'package:sms_alert/models/db/PolicyMsg.dart';
// import 'package:sms_alert/models/db/PolicyMsgDetail.dart';
// import 'package:sms_alert/models/db/PolicyMsgWord.dart';
// import 'package:sms_alert/repository/ContactMapPolicyRepository.dart';

// import 'package:sms_alert/repository/Repository.dart';
// import 'package:sms_alert/repository/WordMapPolicyRepository.dart';
// import 'package:sms_alert/utils/db.dart';
// import 'package:sms_alert/utils/strings.dart';

// class SMS{


//   static void initReceiver(){
//     if(Platform.isAndroid){
//         receiver();
//     }else if(Platform.isIOS){

//     }
//   }

//   static void receiver(){
      
//       SmsReceiver receiver = new SmsReceiver();
//       receiver.onSmsReceived.listen((SmsMessage msg){
//         //  print("sms msg:${msg.body}");
//         //  print("sms id:${msg.id.toString()}");
//         //  print("sms sender: ${msg.sender}");
//         //  print("sms kind: ${msg.kind}");
         
//         //  msg.toMap.forEach((key, value) {
//         //    print("sms tomap: key:$key value:$value");
//         //  });

        
//          MSG.initMsg(msg.sender,msg.body);

//       });

//   }

// }

// class  MSG{

//   static void initMsg(String sender,String message) async {

//       //Get existed policy
//       List<Map<String,dynamic>> results = await Repository.query(ConPolicy.table);
//       List<ConPolicy> policies = results.map((item) => ConPolicy.fromMap(item)).toList();
//       List<ConContact> members;
//       List<ConWord> words;

//       policies.forEach((policy) async {
//             //get all member by policy
//              members = await  ContactMapPolicyRepository.getContactsByPolicyID(policy.policyID);
//              //get all word by policy
//              words = await WordMapPolicyRepository.getWordsByPolicyID(policy.policyID);

//             members.forEach((member) async {
//                String phoneModified = member.phone.replaceAll(new RegExp(r"\s+\b|\b\s|\)|\(|\-"), "");
//               if(phoneModified == sender){               
//                 if(isContainFilter(message.split(' '), words)){

//                   var msgId = DB.generateId();
//                   String date = DateTime.now().toIso8601String();

//                   PolicyMsg policyMsg = new PolicyMsg(
//                     msgID: msgId,
//                     contactID: member.contactID ,
//                     policyID: policy.policyID,
//                     createdDate: date,
//                     createdBy: StringRef.system
//                   );

//                   PolicyMsgDetail policyMsgDetail = new PolicyMsgDetail(
//                       msgID: msgId,
//                       message: message,
//                   );
                  
//                   List<PolicyMsgWord> conWords = [];
                  
//                   words.forEach((word) {
                     
//                      PolicyMsgWord policyMsgWord = new PolicyMsgWord(
//                       msgID: msgId,
//                       wordID: word.wordID
//                      );

//                      conWords.add(policyMsgWord);
//                   });

//                   await _save(policyMsg, policyMsgDetail,conWords).then((result) {
                    
//                     if(result.isSucess){
//                       print("[SMS Service]: ${result.message}" );
//                     }else{
//                       print("[SMS Service]: ${result.message}" );
                      
//                     }
                  
//                   });

//                 }
//               }
//             });
             

//       });

      
//   }

//   static bool isContainFilter(List<String> message,List<ConWord> words ){
//     bool isContainFilter = true;
//     int totalOfWordNeedToContain = words.length;
//     int totalWordAvailable =0;
    
//     message.forEach((text) {
//         words.forEach((word) { 
//           if(text == word.word){
//             totalWordAvailable++;
//           }
//         });  
//     });

//     if(totalWordAvailable<totalOfWordNeedToContain){
//       isContainFilter = false;
//     }
      
//     return isContainFilter;
//   }
//   static Future<DBResult> _save(PolicyMsg policyMsg,PolicyMsgDetail policyMsgDetail,List<PolicyMsgWord> policyMsgWord) async{

//     DBResult dbResult = DBResult(true,DBResult.saveMsg);

//     try{
                    
//       dynamic result = await Repository.insert(PolicyMsg.table, policyMsg);
//       print("[PolicyMsg]Create :$result");

//       dynamic result1 = await Repository.insert(PolicyMsgDetail.table,policyMsgDetail);
//       print("[PolicyMsgDetail]Create :$result1");
      
//       policyMsgWord.forEach((word) async {
//         dynamic result2 = await Repository.insert(PolicyMsgWord.table,word);
//         print("[PolicyMsgWord]Create :$result2");

//       });                    
                    
//     }catch(ex){
//       dbResult.isSucess = false;
//       dbResult.message = ex.toString();
//       print("SMS Service: $ex");
//     }
    

//     return dbResult;

//   }
// }