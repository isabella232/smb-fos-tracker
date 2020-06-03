import 'dart:async';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MapSample extends StatefulWidget {
  MapSample({Key key, this.street, this.city, this.latitude, this.longitude}) : super(key: key);
  String street;
  String city;
  double latitude;
  double longitude;
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(widget.latitude, widget.longitude),
  //   zoom: 19,
  // );
  

  static CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    double lat = widget.latitude;
    double longi = widget.longitude;
    final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(widget.latitude, widget.longitude),
    zoom: 19,
  );
    Marker m= Marker(
      markerId: MarkerId("m"),
    position: LatLng(widget.latitude, widget.longitude),
    draggable: true,
    onDragEnd: (value) {
      lat = value.latitude;
      longi = value.longitude;
    },
  );
  List<Marker> markers = [];
  markers.add(m);
  print("old\n\n");
  print(m.position.latitude);
  print(m.position.longitude);
    return new Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Drag marker to location", style: GoogleFonts.montserrat(),),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("new\n\n\n");
          print(m.position.latitude);
          print(m.position.longitude);
          print(lat);
          print(longi);
          Coordinates coordinates = Coordinates(lat, longi);
          Navigator.pop(context, coordinates);
        },
        label: Text('Confirm'),
        icon: Icon(Icons.check),

      ),
    );
  }

  Future<void> _goToTheLake() async {
    final query = widget.street + ", " + widget.city;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    _kLake = CameraPosition(
      target: LatLng(first.coordinates.latitude, first.coordinates.longitude),
      zoom: 20
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}