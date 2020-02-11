import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';

class ReviewList extends StatelessWidget {

  final Restaurant res;
  ReviewList({ this.res });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ReviewService(restaurant_id: res.restaurant_id).review,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Review> review = snapshot.data;
          return ListView.builder(
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
            return Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
              child: Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.deepOrange,
                  backgroundImage: NetworkImage('https://i.imgur.com/GcqJ5NM.png'),
                ),
                  title: Text('${userData.name}'),
                  subtitle: Text(
                      'Like: ${review.like}, Dislike: ${review.dislike}'
                          '\n${review.content}'
                  ),
                ),
              ),
            );
          } else
            return Loading();
        }
    );
  }
}