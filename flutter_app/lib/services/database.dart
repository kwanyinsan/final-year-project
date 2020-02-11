import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('userdata');
  final CollectionReference resCollection = Firestore.instance.collection('restaurant');
  final CollectionReference reviewCollection = Firestore.instance.collection('review');

  Future<void> newRes(String name, String type, int phone, String location, int like, int dislike, String image) async {
    return await resCollection.document().setData({
      'name': name,
      'type': type,
      'phone': phone,
      'location': location,
      'like': like,
      'dislike': dislike,
      'image': image,
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
        like: doc.data['like'] ?? 0,
        dislike: doc.data['dislike'] ?? 0,
        image: doc.data['image'] ?? '',
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


  Stream<List<Restaurant>> get res {
    return resCollection.snapshots()
        .map(_resListFromSnapshot);
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}