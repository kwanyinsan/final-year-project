import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home/profile_builder.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/models/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            return ProfileBuilder(userData: userData);
          } else {
            return Loading();
          }
        });
    }
}