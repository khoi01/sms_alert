import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/models/db/ConWordMapPolicy.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/ui/home/HomeView.dart';
import 'package:sms_alert/ui/message/Policy/config/selectWord/PolicyConSelecWordtViewContext.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';
import 'package:sms_alert/utils/db.dart';

class PolicyConSelectWordView extends StatefulWidget {

  final String policyID;
  
  PolicyConSelectWordView({Key key, this.policyID}) : super(key: key);

  @override
  _PolicyConSelectWordViewState createState() => _PolicyConSelectWordViewState();
}

class _PolicyConSelectWordViewState extends State<PolicyConSelectWordView> {



  List<ConWord> selectedWords = [];

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Select filter"),
        backgroundColor: Colors.white10,
        actions: [
            TextButton(
              child: WidgetRef.customText(text:"Apply"),
              onPressed: (){
                if(selectedWords.length>0){
                  _save().then((result){
                    if(result.isSucess){
                      WidgetRef.showToasted("Save Success..", true);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeView()), 
                          (Route<dynamic> route) => false,
                      );  
                    }else{
                      WidgetRef.showToasted(result.message, false);

                    }
                  });

                }else{
                   WidgetRef.showToasted("Select word..",false);
                  
                }
              },
            )
        ],
      ),
      body: ListView(
        children:<Widget>[
          PolicyConSelectWordListViewUI(selectedWords: selectedWords,policyID: widget.policyID,),
        ]
      ),
    );
  }

  Future<DBResult> _save() async{

     String date = DateTime.now().toIso8601String();
     DBResult dbResult = DBResult(true,DBResult.saveMsg); 

     selectedWords.forEach((word) {
    
       ConWordMapPolicy conWordMapPolicy = new ConWordMapPolicy(
        wordID: word.wordID,
        policyID: widget.policyID,
        createdDate: date,
        createdBy: StringRef.user     
       );

       try{
         dynamic result = Repository.insert(ConWordMapPolicy.table,conWordMapPolicy);
         print("[ConWordMapPolicy]Create : $result");

       }catch(ex){
         dbResult.isSucess = false;
         dbResult.message = ex.toString();
         print("WordCreateViewFormUI: $ex");       
       }

      });
      return dbResult;
  }
}