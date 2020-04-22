import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

class Restaurant {

    final String restaurant_id;
    final String name;
    final String type;
    final int phone;
    final String image;
    final int price;
    final GeoPoint location;
    final String address;
    final String website;
    final int rating;

    Restaurant({ this.restaurant_id, this.name, this.type, this.phone, this.image, this.price, this.address, this.location, this.website, this.rating});

    Future<String> getAddress() async {
      final coordinates = new Coordinates(location.latitude, location.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      return "${first.addressLine}";
  }

}