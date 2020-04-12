
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetRef{

  static Widget customText({String text}){
    return Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          );
  }


    static void showToasted(String text,bool isSuccess){
     Fluttertoast.showToast(
                        msg: text,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: isSuccess ? Colors.green : Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
  }

}