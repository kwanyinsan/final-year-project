import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/screen/home/review_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/models/restaurant.dart';

class ReviewList extends StatefulWidget {

  final Restaurant res;
  ReviewList({ this.res });

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ReviewService(restaurant_id: widget.res.restaurant_id).review,
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