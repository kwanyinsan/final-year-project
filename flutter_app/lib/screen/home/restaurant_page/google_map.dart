import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class FireMap extends StatefulWidget {

  final Restaurant res;
  FireMap({this.res});

  @override
  State createState() => FireMapState();
}

class FireMapState extends State<FireMap> {
  GoogleMapController mapController;

  Firestore firestore = Firestore.instance;

  /* BehaviorSubject<double> radius = BehaviorSubject(seedValue: 100.0);
   Stream<dynamic> query;*/

  StreamSubscription subscription;
  @override
  Widget build(BuildContext context) {
    print(widget.res.name);
    return Scaffold(
      body: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(22, 113), zoom: 15),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
                mapType: MapType.normal,
            ),
            /*
            Positioned(
                bottom: 50,
                right: 10,
                child:
                FlatButton(
                    child: Icon(Icons.pin_drop),
                    color: Colors.green,
                    onPressed: () => _addGeoPoint()
                )
            ),

             */
            /* Positioned(
              bottom:50,
              left: 10,
              child: Slider(
                min: 100.0,
                max: 500.0,
                divisions: 4,
                value: radius.value,
                label: 'Radius ${radius.value}km',
                activeColor: Colors.green,
                inactiveColor: Colors.green.withOpacity(0.2),
                onChanged: _updateQuery,
              ),
            ) */
          ]
      ),
    );
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  /*
  void _add() {
    var markerIdVal = '1';
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

   */



  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

/*void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(documentList);
    mapController.clearMarkers();
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      double distance = document.data['distance'];
      var marker = Marker(
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindowText: InfoWindowText('Magic Marker', '$distance kilometers from query center')
      );


      mapController.addMarker(marker);
    });
  } */
}

