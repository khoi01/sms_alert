import 'package:sms_alert/models/db/ConContact.dart';
import 'package:sms_alert/models/db/PolicyMsg.dart';
import 'package:sms_alert/models/db/PolicyMsgDetail.dart';
import 'package:sms_alert/models/db/PolicyMsgWord.dart';

class Policy {

  late PolicyMsg? policyMsg;
  late ConContact? conContact;
  late PolicyMsgDetail? policyMsgDetail;
  List<PolicyMsgWord>? policyMsgWord;


  void setPolicyMsg(PolicyMsg? policyMsg){
    this.policyMsg = policyMsg;
  }

  void setConContact(ConContact? conContact){
    this.conContact = conContact;
  }

  void setPolicyMsgDetail(PolicyMsgDetail? policyMsgDetail){
    this.policyMsgDetail = policyMsgDetail;
  }

  void setPolicyMsgWord(List<PolicyMsgWord>? policyMsgWord){
    this.policyMsgWord = policyMsgWord;
  }


}
