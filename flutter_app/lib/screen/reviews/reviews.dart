import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/models/review.dart';

class Reviews extends StatelessWidget {

  @override
  Widget build (BuildContext context) {

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
  ReviewsBuilder({ this.review });

  @override
  Widget build (BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: review.user_id).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userData = snapshot.data;
          return Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
            child: Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.deepOrange,
                  backgroundImage: NetworkImage('${userData.avatar}'),
                ),
                title: Text('${userData.name}'),
                subtitle: Text(
                    'Like: ${review.like}, Dislike: ${review.dislike}'
                        '\n${review.content}'
                ),
              ),
            ),
          );
        } else {
        return Loading();
        }
      }
    );
  }
}