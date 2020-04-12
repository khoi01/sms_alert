import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/repository/WordMapPolicyRepository.dart';
import 'package:sms_alert/ui/message/Policy/config/selectWord/PolicyConSelectWordView.dart';
import 'package:sms_alert/utils/strings.dart';

class PolicyConWordFormViewUI extends StatefulWidget {

  final String policyID;


  PolicyConWordFormViewUI({Key key, this.policyID}) : super(key: key);

  @override
  _PolicyConWordFormViewUIState createState() => _PolicyConWordFormViewUIState();
}

class _PolicyConWordFormViewUIState extends State<PolicyConWordFormViewUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Text(StringRef.empty),
           IconButton(icon: Icon(Icons.add_circle_outline),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => PolicyConSelectWordView(policyID: widget.policyID,)
                ));
            }),
         ],
       ),
    );
  }
}

class PolicyWordListViewUI extends StatefulWidget {

  final String policyID;

  PolicyWordListViewUI({Key key, this.policyID}) : super(key: key);

  @override
  _PolicyWordListViewUIState createState() => _PolicyWordListViewUIState();
}

class _PolicyWordListViewUIState extends State<PolicyWordListViewUI> {

  List<ConWord> _words;

  @override
  void initState() {
    getWordMapPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
       child: _words != null 
       ? ListView.builder(
              shrinkWrap: true, 
              physics: ClampingScrollPhysics(),
              itemCount: _words?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                ConWord word = _words?.elementAt(index);
                return Container(
                  child: Card(
                          child: ListTile(
                          title: Text(word.word ?? ''),
                        ),
                  ),
                );
              },
            )
          : Center(child: Text("")),
    );
  }

  //get list of word that tied with policy
  Future<void> getWordMapPolicy() async{

     _words = await WordMapPolicyRepository.getWordsByPolicyID(widget.policyID);
    refresh();
  }

  void refresh(){
    setState(() {});
  }
}