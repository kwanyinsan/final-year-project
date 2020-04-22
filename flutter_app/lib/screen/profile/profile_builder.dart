import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';


class ProfileBuilder extends StatelessWidget {

  final UserData userData;
  ProfileBuilder({ this.userData });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage('${userData.avatar}'),
                backgroundColor: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text( userData.name ,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 28.0,
                    // fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Icon(Icons.thumb_up, color: Colors.deepOrange,),
                SizedBox(width: 10,),
                Text('Likes: 420',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16.0,
                      //fontWeight: FontWeight.bold,
                    )
                ),
                SizedBox(width: 50,),
                Icon(Icons.people, color: Colors.deepOrange,),
                SizedBox(width: 10,),
                Text('Followers: 69',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16.0,
                      // fontWeight: FontWeight.bold,
                    )
                ),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Icon(Icons.email, color: Colors.deepOrange,),
                SizedBox(width: 10.0),
                Text(
                  userData.email,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey[600],
                height: 60.0,
              ),
            ),
            Text(
              'Bookmarks',
              style: TextStyle(
                color: Colors.deepOrange,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),

    );

  }
}