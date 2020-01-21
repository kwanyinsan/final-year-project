import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  final CollectionReference userCollection = Firestore.instance.collection('userdata');
  final CollectionReference resCollection = Firestore.instance.collection('restaurant');

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

  Future<void> newUser(String name, String school) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'school': school,
    });
  }



  List<Restaurant> _resListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Restaurant(
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
        name: snapshot.data['name'],
        school: snapshot.data['school'],
    );
  }

  Stream<List<Restaurant>> get res {
    return resCollection.snapshots()
        .map(_resListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return resCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}