import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/repository/WordRepository.dart';
import 'package:sms_alert/utils/db.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';

class WordCreateViewFormUI extends StatefulWidget {

  final bool listState;

  WordCreateViewFormUI({Key key, this.listState}) : super(key: key);

  @override
  _WordCreateViewFormUIState createState() => _WordCreateViewFormUIState();
}

class _WordCreateViewFormUIState extends State<WordCreateViewFormUI> {

  
  TextEditingController _wordNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
              flex: 9,
              child: Container(
              child: TextFormField(
                controller: _wordNameController,
                decoration: InputDecoration(
                  labelText: "Input filter name here"
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter filter name";
                  }

                  return null;
                },
              ),
            ),
          ),
         Expanded(
              flex:1,
              child: Container(
              child: IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                  if(_formKey.currentState.validate()){
                    
                    isAlreadyExited(_wordNameController.text).then((isExisted) {
                      if(isExisted){
                        WidgetRef.showToasted("word already exited,please used another word",false);
                      }else{
                        _save().then((result){
                                
                                if(result.isSucess){
                                  WidgetRef.showToasted("Save Success..", true);
                                }else{
                                  WidgetRef.showToasted(result.message, false);
                                }      
                                
                                _wordNameController.text = "";
                                refresh();
                          });
                      }
                      refresh();

                    });

                  }
                },
              ),
            ),
         )
        ],
      ),
    );
  }


  Future<DBResult> _save() async{
    var id = DB.generateId();
    String date = DateTime.now().toIso8601String();
    DBResult dbResult = DBResult(true,DBResult.saveMsg);

    ConWord conWord = new ConWord(
      wordID:  id,
      word: _wordNameController.text,
      status: 1,
      createdDate: date,
      createdBy: StringRef.user      
    );

    try{

      dynamic result = await Repository.insert(ConWord.table,conWord);
      print("[conWord]Create :$result");
    
    }catch(ex){
      dbResult.isSucess = false;
      dbResult.message = ex.toString();
      print("WordCreateViewFormUI: $ex");
    }


    return dbResult;
  }

  Future<bool> isAlreadyExited(String word) async{
    bool isAlreadyExited = true;

    ConWord conWord = await WordRepository.getWordByName(word);
    
    if(conWord == null){
      isAlreadyExited = false;
    }

    return isAlreadyExited;
  }
  void refresh(){
    setState(() {});
  }
}


class WordCreateViewListUI extends StatefulWidget {

  
  WordCreateViewListUI({Key key}) : super(key: key);

  @override
  _WordCreateViewListUIState createState() => _WordCreateViewListUIState();
}

class _WordCreateViewListUIState extends State<WordCreateViewListUI> {
  
  List<ConWord> _words;
  

  @override
  void initState() {
    super.initState();
    getFilters();

  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      //height: MediaQuery.of(context).size.height,
       child: _words != null 
       ? ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _words?.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(child: ListTile(title: Text(_words[index].word)))
                );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  Future<void> getFilters() async{
    List<Map<String,dynamic>>  results = await Repository.query(ConWord.table);
    _words = results.map((item) => ConWord.fromMap(item)).toList();
    _words.sort((a, b) => a.word.compareTo(b.word)); //sort from a to z
    refresh();
  }

  void refresh(){
    setState(() {});
  }
}