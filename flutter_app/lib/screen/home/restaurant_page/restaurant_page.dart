import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_reviews.dart';

class ResPage extends StatelessWidget {

  final Restaurant res;
  ResPage({ this.res });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReviewList(res: res, address: "Placeholder",)
    );
  }
}