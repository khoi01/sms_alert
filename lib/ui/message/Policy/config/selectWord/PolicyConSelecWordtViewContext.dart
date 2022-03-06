import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/repository/WordMapPolicyRepository.dart';

class PolicyConSelectWordListViewUI extends StatefulWidget {

  final String? policyID;
  final List<ConWord>? selectedWords;


  PolicyConSelectWordListViewUI({Key? key, this.policyID, this.selectedWords}) : super(key: key);

  @override
  _PolicyConSelectWordListViewUIState createState() => _PolicyConSelectWordListViewUIState();
}

class _PolicyConSelectWordListViewUIState extends State<PolicyConSelectWordListViewUI> {
  
  List<ConWord>? _words;
    List<bool> _selected = List.generate(20, (i) => false); // initially fill it up with false


  @override
  void initState() {

    getWords();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: _words != null 
       ? ListView.builder(
            
              shrinkWrap: true, 
              physics: ClampingScrollPhysics(),
              itemCount: _words?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                ConWord? word = _words?.elementAt(index);
                return Container(
                  margin: EdgeInsets.all(2),
                  color: _selected[index] ? Colors.green:null,
                                  child: ListTile(
                    
                    title: Text(word?.word ?? ''),
                    //This can be further expanded to showing contacts detail
                    // onPressed().
                    onTap: (){
                      _selected[index] = !_selected[index];
                      //add contact/remove
                      _selected[index] ? widget.selectedWords!.add(word!) : widget.selectedWords!.remove(word); 
                    
                      refresh();
                    },
                  ),
                );
              },
            )
          : Container(
            padding: EdgeInsets.all(9),
            child: Center(
              child: Text(
                "Please create filter first..",
                style: TextStyle(
                  color: Colors.red
                ),
              )
            ),
          ),
    );
  }


    void getWords() async{
    List<Map<String,dynamic>> results = await Repository.query(ConWord.table);
    
    List<ConWord?>? existedWords = await WordMapPolicyRepository.getWordsByPolicyID(widget.policyID);
    
    if(results.length>0){
      _words = results.map((item) => ConWord.fromMap(item)).cast<ConWord>().toList();
      
      if(existedWords != null){
        existedWords.forEach((wordRemove) {
          _words!.removeWhere((item) => item.wordID == wordRemove!.wordID);
        }); 
      }

      _words!.sort((a, b) => a.word!.compareTo(b.word!)); //sort from a to z

    } 

    refresh();
  }




  void refresh(){
    setState(() {});
  }
}