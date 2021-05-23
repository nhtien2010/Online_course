import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_course/gui/pages/LoginPage.dart';

class AppUtil {

  String hourFormat(num hour){
    return hour.toStringAsFixed(0) + "h";
  }

  void showAlert(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            title: Text(title),
            content: Text(content),
            // actions: [
            //   FlatButton(
            //     child: Text("Ok"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   )
            // ],
          );
        });
  }

  void showSignUpAlert(BuildContext context, String title, String content, bool success) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            title: Text(title),
            content: Text(content),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  if(success){
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => LoginPage()));
                  }else
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
