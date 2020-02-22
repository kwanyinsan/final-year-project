import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as location2;
import 'package:flutter_app/shared/dialogbox.dart';
import 'package:geocoder/geocoder.dart';


class MarkerMap extends StatefulWidget {
  @override
  _MarkerMapState createState() => _MarkerMapState();
}

class _MarkerMapState extends State<MarkerMap> {

  ArgumentCallback<LatLng> onTap;
  Completer<GoogleMapController> mapController;
  location2.LocationData currentLocation;
  List<Marker> allMarkers = [];
  LatLng markerLocation;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  void addMarker(LatLng point) {
    print(point);
    markerLocation = point;
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: true,
      onTap: () {
        print('Marker Tapped');
      },
      position: point,
    ));
    setState(() {});
  }

  _getLocation() async {
    var location = new location2.Location();
    try {
      currentLocation = await location.getLocation();

      print("locationLatitude: ${currentLocation.latitude}");
      print("locationLongitude: ${currentLocation.longitude}");
      setState(
              () {}); //rebuild the widget after getting the current location of the user
    } on Exception {
      currentLocation = null;
    }
  }

  String _location;
  void updateLocation(String location) async {
    setState(() {
      this._location = location;
    });
  }

  Future<String> locationToAddress(LatLng location) async{
    final coordinates = new Coordinates(location.latitude, location.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return "${first.addressLine}";
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text('Upload Location'),
          ),
          body: Column(
            children: [
              Flexible(
                flex: 2,
                child: GoogleMap(
                  markers: Set.from(allMarkers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation.latitude, currentLocation.longitude) ?? LatLng(22.28552, 114.15769),
                    zoom: 17,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController.complete(controller);
                  },
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onTap: (point) async {
                    addMarker(point);
                    await locationToAddress(markerLocation).then(updateLocation);
                  },
                ),
              ),
              RaisedButton(
                  child: Text('Upload',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.deepOrange,
                  onPressed:() {
                    if (markerLocation == null) {
                      print('error');
                    } else
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Confirm This Location?"),
                              content: Text(_location ?? 'Loading...'),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                FlatButton(
                                  child: new Text("Yes"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context, markerLocation);
                                  },
                                ),
                                FlatButton(
                                  child: new Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context, markerLocation);
                                  },
                                ),
                              ],
                            );
                          }
                      );
                  }
                  ),
            ],
          )
      );
    }
  }