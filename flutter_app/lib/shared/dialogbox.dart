import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, arg1) {

  // set up the buttons
  Widget remindButton = FlatButton(
    child: Text('ok'),
    onPressed:  () {
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );
  Widget launchButton = FlatButton(
    child: Text("Launch missile"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("hi bro"),
    content: Text("you have not sign in yet."),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}