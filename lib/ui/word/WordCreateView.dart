import 'package:flutter/material.dart';
import 'package:sms_alert/ui/word/WordCreateViewContent.dart';
import 'package:sms_alert/utils/strings.dart';

class WordCreateView extends StatefulWidget {
  WordCreateView({Key? key}) : super(key: key);

  @override
  _WordCreateViewState createState() => _WordCreateViewState();
}

class _WordCreateViewState extends State<WordCreateView> {

  // final bool _listState = false;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title:Text(StringRef.createFilterTitle),
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
             WordCreateViewFormUI(),
             WordCreateViewListUI(),             
           ],
         ),
       ),
    );
  }
}