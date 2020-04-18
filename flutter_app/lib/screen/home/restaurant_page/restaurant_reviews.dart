import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/shared/star_rating.dart';

class ReviewList extends StatelessWidget {

  final Restaurant res;
  final String address;
  ReviewList({this.res, this.address});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(res.image, fit: BoxFit.cover,),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${res.name}', style: Theme.of(context).textTheme.title,),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(address),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("${res.like}"),
                                    Text("Likes")
                                  ],
                                ),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("${res.dislike}"),
                                    Text("Disikes")
                                  ],
                                ),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("0"),
                                    Text("Bookmarked")
                                  ],
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: NetworkImage(res.image),
                                fit: BoxFit.cover
                            )
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(title: Text("about ${res.name} ..."),),
                        Divider(),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text('${res.phone}'),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Website"),
                          subtitle: Text('${res.website}'),
                          leading: Icon(Icons.web),
                        ),
                        ListTile(
                          title: Text("Joined Date"),
                          subtitle: Text("4-2-2020"),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: ReviewService(restaurant_id: res.restaurant_id).review,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Review> review = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: review.length,
                          itemBuilder: (context, index) {
                            return ReviewTile(review: review[index]);
                          },
                        );
                        //TODO: add if no reviews, then say no reviews
                      } else {
                        return Loading();
                      }
                    },
                  ),
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}


class ReviewTile extends StatelessWidget {

  final Restaurant res;
  final Review review;
  ReviewTile({ this.res, this.review });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService(uid: review.user_id).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 0.0,
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: ListTile(
                      //trailing: Icon(Icons.chevron_right),
                      leading: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.deepOrange,
                      backgroundImage: NetworkImage('${userData.avatar}'),
                    ),
                      title: Text('${userData.name}'),
                      subtitle: Text(
                          'Followers: 0'
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 20, 5),
                    child: StarRating(
                      rating: review.rating,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 20, 20),
                    child: Text(review.content,
                      style: TextStyle(fontSize: 18),),
                  ),
                  Image.network(review.image),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 20, 20, 20),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.thumb_up, color: Colors.blueAccent,),
                        Text(' ${review.like}'),
                        SizedBox(width: 20),
                        Icon(Icons.thumb_down, color: Colors.redAccent,),
                        Text(' ${review.dislike}'),
                      ],
                    ),
                  ),
                  Divider(thickness: 1,)
                ],
              ),
            );
          } else
            return Loading();
        }
    );
  }
}