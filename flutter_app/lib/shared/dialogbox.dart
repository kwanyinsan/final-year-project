import 'package:flutter/material.dart';

import '../screen/authenticate/authenticate.dart';

showAlertDialog(BuildContext context, textTitle, textInfo, button, callback) {

  // set up the buttons
  Widget remindButton = FlatButton(
    child: Text(button),
    onPressed:  () {
      Navigator.of(context).pop();
      if (callback == 'none') {
      }
      else if (callback == 'auth') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Authenticate()),
        );
      }
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
    title: Text(textTitle),
    content: Text(textInfo),
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