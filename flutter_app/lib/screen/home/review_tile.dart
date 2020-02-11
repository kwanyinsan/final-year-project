import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/models/user.dart';

class ReviewTile extends StatefulWidget {

  final Restaurant res;
  final Review review;
  ReviewTile({ this.res, this.review });

  @override
  _ReviewTileState createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: widget.review.user_id).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
            child: Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('${userData.name}'),
                subtitle: Text(
                    'Like: ${widget.review.like}, Dislike: ${widget.review
                        .dislike}'
                        '\n${widget.review.content}'
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