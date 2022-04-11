import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/repository/Repository.dart';
import 'package:sms_alert/repository/WordRepository.dart';
import 'package:sms_alert/ui/word/WordCreateViewContent.dart';
import 'package:sms_alert/utils/Util.dart';
import 'package:sms_alert/utils/db.dart';
import 'package:sms_alert/utils/strings.dart';
import 'package:sms_alert/utils/widgets.dart';

class WordCreateView extends StatefulWidget {
  WordCreateView({Key? key}) : super(key: key);

  @override
  _WordCreateViewState createState() => _WordCreateViewState();
}

class _WordCreateViewState extends State<WordCreateView> {
  final _formKey = GlobalKey<FormState>();
  final _wordNameController = TextEditingController();
  List<ConWord>? _words;
  bool _showProgress = true;

  @override
  void initState() {
    super.initState();
    getWords();
  }

  // final bool _listState = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringRef.createFilterTitle),
          backgroundColor: Colors.white10,
          actions: [
            //  FlatButton(
            //    child:WidgetRef.customText(text:"Create"),
            //    onPressed: (){

            //    },
            //  )
          ],
        ),
        body: ListView(
          children: <Widget>[
            WordCreateViewFormUI(
              formKey: _formKey,
              wordNameController: _wordNameController,
              onSubmit: () {
                check();
              },
            ),
            _showProgress ? CircularProgressIndicator(
              
            ) : WordCreateViewListUI(
              words: _words,
            ),
          ],
        ),
      ),
    );
  }

  // verify
  void check() {
    if (_formKey.currentState!.validate()) {
      isAlreadyExited(_wordNameController.text).then((isExisted) {
        if (isExisted) {
          WidgetRef.showToasted(
              "word already exited,please used another word", false);
        } else {
         
            _save().then((result) {
             setState(() {
              //re-initialize list
               getWords();
               AppUtils.closeKeyboard(context);

                if (result.isSucess) {
                WidgetRef.showToasted("Save Success..", true);
              } else {
                WidgetRef.showToasted(result.message, false);
              }

              _wordNameController.text = "";
             });
            });
          
        }
      });
    }
  }

  Future<DBResult> _save() async {
    var id = DB.generateId();
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    DBResult dbResult = DBResult(true, DBResult.saveMsg);

    ConWord conWord = new ConWord(
        wordID: id,
        word: _wordNameController.text,
        status: 1,
        createdDate: date,
        createdBy: StringRef.user);

    try {
      dynamic result = await Repository.insert(ConWord.table, conWord);
      print("[conWord]Create :$result");
    } catch (ex) {
      dbResult.isSucess = false;
      dbResult.message = ex.toString();
      print("WordCreateViewFormUI: $ex");
    }

    return dbResult;
  }

  Future<void> getWords() async {
    await Repository.query(ConWord.table).then((results) {
      
      setState(() {
        _words =
          results.map((item) => ConWord.fromMap(item)).cast<ConWord>().toList();
      _words!.sort((a, b) => a.word!.compareTo(b.word!)); //sort from a to z
      
      _showProgress = false;
      });
    });
  }

  Future<bool> isAlreadyExited(String word) async {
    bool isAlreadyExited = true;

    ConWord? conWord = await WordRepository.getWordByName(word);

    if (conWord == null) {
      isAlreadyExited = false;
    }

    return isAlreadyExited;
  }
}
