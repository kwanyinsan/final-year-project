import 'package:flutter/material.dart';

import '../screen/authenticate/authenticate.dart';

showAlertDialog(BuildContext context, textTitle, textInfo, button, callback) {

  // set up the buttons
  Widget remindButton = FlatButton(
    child: Text(button),
    onPressed:  () {
      if (callback == 'none') {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
      else if (callback == 'auth') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Authenticate()),
        );
      }
    },
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
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
          child: alert,
        onWillPop: () async => false,
      );
    },
  );
}