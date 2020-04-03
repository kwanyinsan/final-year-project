import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screen/profile/profile_builder.dart';
import 'package:flutter_app/screen/setting/setting_builder.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build (BuildContext context) {

    User user = Provider.of<User>(context);

    if (user.uid == null) {
      Navigator.pop(context);
    }

    return StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            return SettingBuilder(userData: userData);
          } else {
            return Loading();
          }
        });
    }
}