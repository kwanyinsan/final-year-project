import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

class Restaurant {

    final String restaurant_id;
    final String name;
    final String type;
    final int phone;
    final int like;
    final int dislike;
    final String image;
    final int price;
    final GeoPoint location;
    final String address;

    Restaurant({ this.restaurant_id, this.name, this.type, this.phone, this.like, this.dislike, this.image, this.price, this.address, this.location});

    Future<String> getAddress() async {
      final coordinates = new Coordinates(location.latitude, location.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      return "${first.addressLine}";
  }

}