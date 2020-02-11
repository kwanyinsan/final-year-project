import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/review_list.dart';

class ResPage extends StatelessWidget {

  final Restaurant res;
  ResPage({ this.res });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(res.name+"'s Review"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ReviewList(res: res),
      backgroundColor: Colors.deepOrange[100],
    );
  }
}