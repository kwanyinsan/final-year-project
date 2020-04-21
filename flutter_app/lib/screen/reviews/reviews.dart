import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/shared/star_rating.dart';

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ReviewService().allReview,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Review> reviews = snapshot.data;
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewsBuilder(review: reviews[index]);
              },
            );
          } else {
            return Loading();
          }
        });
  }
}

class ReviewsBuilder extends StatelessWidget {
  final Review review;
  ReviewsBuilder({this.review});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService(uid: review.user_id).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return ReviewsBuilder2(review: review, userData: userData);
          } else {
            return Loading();
          }
        });
  }
}

class ReviewsBuilder2 extends StatelessWidget {
  final Review review;
  final UserData userData;
  ReviewsBuilder2({this.review, this.userData});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService(uid: review.restaurant_id).resData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Restaurant resData = snapshot.data;
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
                        title: Text('${userData.name} @ ${resData.name}'),
                        subtitle: Text('Followers: 0'),
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
                      child: Text(
                        review.content,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Image.network(review.image),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 20, 20, 20),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            color: Colors.blueAccent,
                          ),
                          Text(' ${review.like}'),
                          SizedBox(width: 20),
                          Icon(
                            Icons.thumb_down,
                            color: Colors.redAccent,
                          ),
                          Text(' ${review.dislike}'),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                ),
              );
          } else
            return Loading();
        });
  }
}
