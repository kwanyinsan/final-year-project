import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_page.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/models/review.dart';

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
            return Padding(
              padding: EdgeInsets.fromLTRB(5, 3, 5, 2),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  splashColor: Colors.deepOrange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResPage(res: resData)),
                    );
                  },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.deepOrange,
                        backgroundImage: NetworkImage(userData.avatar),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      title: Text(userData.name + ' @ ' + resData.name),
                      subtitle:
                          Text('Like: ${review.like}, Dislike: ${review.dislike}'
                              '\n${review.content}'),
                    ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
