import 'package:flutter/material.dart';
import 'package:sms_alert/components/ComponentCircleWord.dart';
import 'package:sms_alert/components/ComponentMessageContent.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/models/model/Policy.dart';
import 'package:sms_alert/repository/WordRepository.dart';

class PolicyMsgViewContentUI extends StatefulWidget {
  final List<ComponentMessageContent>? componentMessageContents;

  PolicyMsgViewContentUI({
    Key? key,
    required this.componentMessageContents,
  }) : super(key: key);

  @override
  _PolicyMsgViewContentUIState createState() => _PolicyMsgViewContentUIState();
}

class _PolicyMsgViewContentUIState extends State<PolicyMsgViewContentUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      //height: MediaQuery.of(context).size.height,
      child: listViewBuilder(),
    );
  }

  Widget listViewBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: widget.componentMessageContents?.length,
      itemBuilder: (BuildContext context, int index) {
        ComponentMessageContent? component =
            widget.componentMessageContents?[index];

        return ComponentMessageContent(
            policy: component?.policy,
            componentcircleWords: component?.componentcircleWords);
      },
    );
  }

  Future<List<ComponentCircleWord>?> initWords(Policy? policy) async {
    List<ComponentCircleWord> componentCircleWords = [];

    ConWord? conWord = await WordRepository.getWordByWordID(
        policy?.policyMsgWord?.first.wordID);
    componentCircleWords.add(ComponentCircleWord(conWord: conWord));

    componentCircleWords
        .add(ComponentCircleWord(conWord: ConWord(word: "Initial")));

    return componentCircleWords;
  }
}
