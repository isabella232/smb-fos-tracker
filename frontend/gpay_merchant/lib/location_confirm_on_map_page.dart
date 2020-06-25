/*
Copyright 2020 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  MapView({Key key, this.street, this.city, this.latitude, this.longitude})
      : super(key: key);
  String street;
  String city;
  double latitude;
  double longitude;

  @override
  State<MapView> createState() => MapViewState();
}

/*
 * This class contains the view to confirm the location of the business.
 * It takes in the initial coordinates and returns the updated ones after
 * the user has verified them.
 */

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    double latitudeAfterUserChange = widget.latitude;
    double longitudeAfterUserChange = widget.longitude;
    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 19,
    );
    Marker storePositionMarker = Marker(
      markerId: MarkerId("m"),
      position: LatLng(widget.latitude, widget.longitude),
      draggable: true,
      onDragEnd: (value) {
        latitudeAfterUserChange = value.latitude;
        longitudeAfterUserChange = value.longitude;
      },
    );
    List<Marker> markers = [];
    markers.add(storePositionMarker);
    return new Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Drag marker to location",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        markers: Set.from(markers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Coordinates coordinates =
              Coordinates(latitudeAfterUserChange, longitudeAfterUserChange);
          Navigator.pop(context, coordinates);
        },
        label: Text('Confirm'),
        icon: Icon(Icons.check),
      ),
    );
  }
}
