import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('userdata');
  final CollectionReference resCollection = Firestore.instance.collection('restaurant');

  Future<void> newRes(String name, String type, int phone, GeoPoint location, String image, String website, int rating) async {
    return await resCollection.document().setData({
      'name': name,
      'type': type,
      'phone': phone,
      'location': location,
      'image': image,
      'website' : website,
      'rating' : rating,
    });
  }

  Future<void> newUser(String name, String school, String email, String avatar) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'school': school,
      'email' : email,
      'avatar' : avatar,
    });
  }

  List<Restaurant> _resListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Restaurant(
        restaurant_id: doc.documentID ?? '',
        name: doc.data['name'] ?? '',
        phone: doc.data['phone'] ?? 0,
        type: doc.data['type'] ?? '',
        price: doc.data['price'] ?? 0,
        image: doc.data['image'] ?? '',
        location: doc.data['location'] ?? new GeoPoint(0, 0),
        website: doc.data['website'] ?? '',
        rating: doc.data['restaurant_rating'] ?? 0,
        //location: _getLocation(new Coordinates(doc.data['location'].latitude, doc.data['location'].longitude)),
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'] ?? [],
      school: snapshot.data['school'] ?? [],
      email: snapshot.data['email'] ?? [],
      avatar: snapshot.data['avatar'] ?? [],
    );
  }

  Restaurant _resDataFromSnapshot(DocumentSnapshot snapshot) {
    return Restaurant(
      restaurant_id: snapshot.documentID ?? '',
      name: snapshot.data['name'] ?? '',
      phone: snapshot.data['phone'] ?? 0,
      type: snapshot.data['type'] ?? '',
      price: snapshot.data['price'] ?? 0,
      image: snapshot.data['image'] ?? '',
      location: snapshot.data['location'] ?? new GeoPoint(0, 0),
      website: snapshot.data['website'] ?? '',
      rating: snapshot.data['restaurant_rating'] ?? 0,
    );
  }


  Stream<List<Restaurant>> get res {
    return resCollection.snapshots()
        .map(_resListFromSnapshot);
  }
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<Restaurant> get resData {
    return resCollection.document(uid).snapshots()
        .map(_resDataFromSnapshot);
  }

}