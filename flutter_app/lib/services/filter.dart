import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/restaurant.dart';


class FilterService {

  final List<String> filter;
  FilterService({ this.filter });

  // collection reference
  final CollectionReference resCollection = Firestore.instance.collection('restaurant');

  bool stringContainsItemFromList(String inputStr, List<String> items) {
    if (items.length == 0) {
      return true;
    }
    for(int i = 0; i < items.length; i++) {
      if(inputStr.contains(items[i])) {
        return true;
      }
    }
    return false;
  }

  List<Restaurant> _resListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Restaurant(
        restaurant_id: doc.documentID ?? '',
        name: doc.data['name'] ?? '',
        phone: doc.data['phone'] ?? 0,
        type: doc.data['type'] ?? '',
        like: doc.data['like'] ?? 0,
        dislike: doc.data['dislike'] ?? 0,
        price: doc.data['price'] ?? 0,
        image: doc.data['image'] ?? '',
        //location: _getLocation(new Coordinates(doc.data['location'].latitude, doc.data['location'].longitude)),
      );
    }).toList();
  }


}