import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';


class SettingBuilder extends StatelessWidget {

  final UserData userData;
  SettingBuilder({ this.userData });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey[600],
                height: 60.0,
              ),
            ),
            Text(
              'Language',
            //  style: TextStyle(
              //  color: Colors.grey,
             //   letterSpacing: 1.0,
            //  ),
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                SizedBox(width: 10.0),
                SizedBox(width: 10.0),
                SizedBox(width: 10.0),
                Text(
                  'Eng',
                ),
                SizedBox(width: 10.0),
                SizedBox(width: 10.0),
                Text(
                  '中',
                ),
                SizedBox(height: 20,),

              ],
            ),


            SizedBox(height: 20,),
            Text(
              'About Us',
            ),
            SizedBox(height: 20,),
            Text(
              'Agreement',
            ),

          ],

        ),

      ),

    );

  }
}