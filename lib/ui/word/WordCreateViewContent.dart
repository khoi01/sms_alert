import 'package:flutter/material.dart';
import 'package:sms_alert/models/db/ConWord.dart';

class WordCreateViewFormUI extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController wordNameController;
  final Function onSubmit;

  WordCreateViewFormUI(
      {Key? key,
      required this.formKey,
      required this.wordNameController,
      required this.onSubmit})
      : super(key: key);

  @override
  _WordCreateViewFormUIState createState() => _WordCreateViewFormUIState();
}

class _WordCreateViewFormUIState extends State<WordCreateViewFormUI> {
  // TextEditingController _wordNameController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              child: TextFormField(
                controller: widget.wordNameController,
                decoration:
                    InputDecoration(labelText: "Input filter name here"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter filter name";
                  }

                  return null;
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {
                  widget.onSubmit();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
 }

class WordCreateViewListUI extends StatefulWidget {

  final List<ConWord>? words;
  WordCreateViewListUI({Key? key, required this.words}) : super(key: key);

  @override
  _WordCreateViewListUIState createState() => _WordCreateViewListUIState();
}

class _WordCreateViewListUIState extends State<WordCreateViewListUI> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      //height: MediaQuery.of(context).size.height,
      child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: widget.words?.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                        child: ListTile(title: Text(widget.words![index].word!))));
              },
            )
    );
  }

  


}
