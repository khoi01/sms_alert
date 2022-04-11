import 'package:flutter/material.dart';
import 'package:sms_alert/components/ComponentCircleWord.dart';
import 'package:sms_alert/components/ComponentMessageContent.dart';
import 'package:sms_alert/models/db/ConWord.dart';
import 'package:sms_alert/models/model/Policy.dart';
import 'package:sms_alert/repository/PolicyMsgRepository.dart';
import 'package:sms_alert/repository/PolicyRepository.dart';
import 'package:sms_alert/repository/WordMapPolicyRepository.dart';
import 'package:sms_alert/repository/WordRepository.dart';
import 'package:sms_alert/ui/message/Policy/config/menu/PolicyConMenuView.dart';
import 'package:sms_alert/ui/message/Policy/msg/PolicyMsgViewContent.dart';

class PolicyMsgView extends StatefulWidget {
  final String policyID;
  final Function onTriggerState;

  PolicyMsgView(
      {Key? key, required this.policyID, required this.onTriggerState})
      : super(key: key);

  @override
  _PolicyMsgViewState createState() => _PolicyMsgViewState();
}

class _PolicyMsgViewState extends State<PolicyMsgView>
    with WidgetsBindingObserver {
  String? _policyName;
  List<Policy>? _policies;
  bool _isShowProgress = true;
  List<ComponentMessageContent>? _componentMessageContents;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    openPolicy();
    getConPolicy();
    getPolicyMsg();
    test();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      setState(() {
        getPolicyMsg();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onTriggerState();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(_policyName ?? ''),
            backgroundColor: Colors.white10,
            actions: <Widget>[
              InkWell(
                  onTap: () {
                    setState(() {
                      //refresh
                      getPolicyMsg();
                      openPolicy();
                    });
                  },
                  child: Icon(Icons.refresh)),
              _simplePopup(),
            ],
          ),
          body: _isShowProgress
              ? Center(child: Text("No message available"))
              : ListView(children: <Widget>[
                  PolicyMsgViewContentUI(
                    componentMessageContents: _componentMessageContents,
                  ),
                ])),
    );
  }

  void getConPolicy() async {
    await PolicyRepository.getPolicyById(widget.policyID).then((conPolicy) {
      // print(conPolicy);

      setState(() {
        if (conPolicy != null) {
          _policyName = conPolicy.policyName;
        }
      });
    });
  }

  void getPolicyMsg() async {
    PolicyMsgRepository.getPoliciesMsgByPolicyID(widget.policyID)
        .then((policies) {
      if ((policies?.length ?? 0) > 0) {
        //setState(() {
        _policies = policies;
        _policies?.sort((a, b) => -int.parse(a.policyMsg?.createdDate ?? '0')
            .compareTo(int.parse(b.policyMsg?.createdDate ?? '0')));

        _policies?.forEach((element) {
          print(DateTime.fromMillisecondsSinceEpoch(
              int.parse(element.policyMsg?.createdDate ?? "0")));

          // _isShowProgress = false;
        });

        initComponentMessageContents();
        //});
      }
    });
  }

  //want to notify system that user already read all the message
  void openPolicy() async {
    await PolicyRepository.openPolicyByPolicyID(widget.policyID)
        .then((isOpenPolicy) => {});
  }

  void initComponentMessageContents() {
    setState(() {
      _componentMessageContents = [];
      List<ConWord?>? words = [];

      List<ComponentCircleWord>? componentCircleWords = [];
      _policies?.forEach((Policy? policy) {
        // print(policy?.policyMsg?.msgID);
        policy?.policyMsgWord?.forEach((item) async {
          ConWord? conWord = await WordRepository.getWordByWordID(item.wordID);
          // print(conWord?.word);
          words.add(conWord);
        });

        // print("words length is ${words.length}");

        words.forEach((item) {
          componentCircleWords.add(ComponentCircleWord(conWord: item));
        });

        _componentMessageContents?.add(ComponentMessageContent(
            policy: policy, componentcircleWords: componentCircleWords));
      });

      _isShowProgress = false;
    });
  }

  //menu pop
  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Policy Info"),
          ),
          // PopupMenuItem(
          //   value: 2,
          //   child: Text("Create Filter"),
          // ),
        ],
        onSelected: (value) async {
          if (value == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PolicyConMenuView(
                          policyID: widget.policyID,
                        )));
          } else {}
        },
      );

  void test() {
    WordRepository.getAllWord().then((words) {
      print('word length [WordRepository] ${words?.length}');
      words?.forEach((element) {
        print(element?.word);
        print(element?.wordID);
      });
    });

    print("=========");
    WordMapPolicyRepository.getWordsByPolicyID(widget.policyID).then((words) {
      print('word length [WordMapPolicyRepository] ${words?.length}');
      words?.forEach((element) {
        print(element?.wordID);
        print(element?.word);
        print(element?.wordID);
      });
    });
    print("=========");

    WordMapPolicyRepository.getAllWord().then((words) {
      print('word length [WordMapPolicyRepository] ${words?.length}');
      words?.forEach((element) {
        print(element?.word);
        print(element?.wordID);
      });
    });
  }
}
