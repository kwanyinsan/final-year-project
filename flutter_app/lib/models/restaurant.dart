import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {

  final String restaurant_id;
  final String name;
  final String type;
  final int phone;
  final GeoPoint location;
  final int like;
  final int dislike;
  final String image;
  final int price;

  Restaurant({ this.restaurant_id, this.name, this.type, this.phone, this.location, this.like, this.dislike, this.image, this.price});

}