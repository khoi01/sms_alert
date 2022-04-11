import 'package:flutter/material.dart';
import 'package:sms_alert/components/ComponentCircleWord.dart';
import 'package:sms_alert/models/model/Policy.dart';

class ComponentMessageContent extends StatelessWidget {
  final Policy? policy;
  final List<ComponentCircleWord>? componentcircleWords;
  const ComponentMessageContent(
      {Key? key,
      required this.policy,
      required this.componentcircleWords})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item();
  }

  
  Widget item(){

    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              policy?.conContact?.displayName ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateTime.fromMillisecondsSinceEpoch(int.parse(
                    policy?.policyMsg?.createdDate?.toString() ?? "0"))
                .toIso8601String()),
            Text(
              policy?.policyMsgDetail?.message ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Wrap(
              children: componentcircleWords ?? []
            )
          ],
        ),
      ),
    );
  }
}
