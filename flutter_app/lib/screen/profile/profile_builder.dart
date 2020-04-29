import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_reviews.dart';

class ProfileBuilder extends StatelessWidget {
  final UserData userData;
  ProfileBuilder({this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
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
            child: Text(userData.name,
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 28.0,
                  // fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: Colors.deepOrange,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Likes: 420',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16.0,
                    //fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: 50,
              ),
              Icon(
                Icons.people,
                color: Colors.deepOrange,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Followers: 69',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16.0,
                    // fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.deepOrange,
              ),
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
          BookmarkedRes(),
        ],
      ),
    );
  }
}

class BookmarkedRes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().res,
      builder: (context, snapshot) {
        List<Restaurant> res = List();
        if (snapshot.hasData) {
          res = snapshot.data;
        }
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: res.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Material(
                      color: Colors.deepOrange[200],
                      child: InkWell(
                        splashColor: Colors.deepOrange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewList(
                                    res: res[index], address: "Placeholder")),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(res[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.restaurant_menu),
                                Text(
                                  ' ${res[index].name}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
