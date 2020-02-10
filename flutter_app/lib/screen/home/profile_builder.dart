import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';


class ProfileBuilder extends StatelessWidget {

  final UserData userData;
  ProfileBuilder({ this.userData });

  @override
  Widget build(BuildContext context) {
    return Text( 'Name: '+  userData.name + '\nSchool: '+ userData.school);
  }
}