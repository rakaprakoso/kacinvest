import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Dialog{

   static _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            Icon(Icons.check_circle),
            Text(
              'Success!'
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
  
}