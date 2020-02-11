import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/review.dart';

class ReviewTile extends StatelessWidget {

  final Restaurant res;
  final Review review;
  ReviewTile({ this.res, this.review });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text('${review.user_id}'),
          subtitle: Text('Like: ${review.like}, Dislike: ${review.dislike}'
              '\n${review.content}'
          ),
        ),
      ),
    );
  }
}