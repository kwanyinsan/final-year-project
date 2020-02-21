import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';


class SearchService {
  Future<String> getAddress(GeoPoint geoPoint) async {
    final coordinates = new Coordinates(geoPoint.latitude, geoPoint.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return "${first.addressLine}";
  }

}