import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/review.dart';

class ReviewService {

  String restaurant_id;
  ReviewService({ this.restaurant_id });

  // collection reference
  final CollectionReference reviewCollection = Firestore.instance.collection('review');

  Future<void> newReview(String restaurant_id, String user_id, String content, String image, int like, int dislike, double rating) async {
    return await reviewCollection.document().setData({
      'restaurant_id': restaurant_id,
      'user_id': user_id,
      'review_content': content,
      'image': image,
      'like': like,
      'dislike': dislike,
      'rating' : rating,
    });
  }

  List<Review> _reviewFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Review(
        restaurant_id: doc.data['restaurant_id'] ?? [],
        content: doc.data['review_content'] ?? [],
        dislike: doc.data['review_dislike'] ?? 0,
        like: doc.data['review_like'] ?? 0,
        user_id: doc.data['user_id'] ?? [],
        image: doc.data['image'] ?? '',
        rating: doc.data['rating'] ?? 0.0,
      );
    }).toList();
  }

  Stream<List<Review>> get review {
    return reviewCollection.where('restaurant_id', isEqualTo: restaurant_id).snapshots()
        .map(_reviewFromSnapshot);
  }

  Stream<List<Review>> get allReview {
    return reviewCollection.snapshots()
        .map(_reviewFromSnapshot);
  }


}