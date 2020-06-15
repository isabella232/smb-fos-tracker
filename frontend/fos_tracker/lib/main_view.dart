import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fos_tracker/agent_and_merchant_info_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Completer<GoogleMapController> controller;
  static LatLng _initialPosition;
  Set<Marker> agentMarkers = new Set();
  Set<Marker> merchantMarkers = new Set();
  bool agentView = true;
  LatLng loc = _initialPosition;
  LatLng loc1 = _initialPosition;

  //TODO: use actual coordinates
  List<LatLng> agentCoordinates = [
    LatLng(22.532372, 88.363407),
    LatLng(22.525558, 88.369540),
    LatLng(22.527316, 88.362249),
    LatLng(22.527125, 88.368211),
    LatLng(22.532232, 88.353498),
    LatLng(22.524458, 88.369430),
    LatLng(22.529716, 88.362233),
    LatLng(22.527140, 88.368200)
  ];
  List<LatLng> merchantCoordinates = [
    LatLng(22.532372, 88.363407),
    LatLng(22.525558, 88.369540),
    LatLng(22.527316, 88.362249),
    LatLng(22.527125, 88.368211),
    LatLng(22.532232, 88.353498),
    LatLng(22.524458, 88.369430),
    LatLng(22.529716, 88.362233),
    LatLng(22.527140, 88.368200)
  ];

  void initState() {
    _getUserLocation();
    for (var x in agentCoordinates) {
      agentMarkers.add(
        Marker(
            markerId: MarkerId(x.longitude.toString()),
            position: x,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AgentPage()));
            },
//            icon: BitmapDescriptor.fromAsset("images/agent.png")
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
        ),
      );
    }
    for (var x in merchantCoordinates) {
      merchantMarkers.add(
        Marker(
            markerId: MarkerId(x.longitude.toString()),
            position: x,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MerchantPage()));
            },
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//            icon: BitmapDescriptor.fromAsset(
//              "images/merchant.png",
//            )
        ),
      );
    }
    super.initState();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      loc = _initialPosition;
      loc1 = _initialPosition;
      print('${placemark[0].name}');
      agentMarkers.add(Marker(markerId: MarkerId("Vanshika"), position: loc));
      agentMarkers.add(Marker(markerId: MarkerId("Vanshika1"), position: loc1));
    });
  }

  _onMapCreated(GoogleMapController controllerArg) async {
    setState(() {
      controller.complete(controllerArg);
    });
  }

  void updateMarker() {
    setState(() {
      if (loc != null) {
        loc = LatLng(loc.latitude + 0.000010, loc.longitude + 0.000010);
        loc1 = LatLng(loc1.latitude - 0.000010, loc1.longitude - 0.000010);
        agentMarkers.removeWhere((m) => m.markerId.value == "Vanshika");
        agentMarkers.add(Marker(
          markerId: MarkerId("Vanshika"),
          position: loc, // updated position
        ));
        agentMarkers.removeWhere((m) => m.markerId.value == "Vanshika1");
        agentMarkers.add(Marker(
          markerId: MarkerId("Vanshika1"),
          position: loc1, // updated position
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => updateMarker());
    return Scaffold(
      appBar: AppBar(title: agentView ? Text("Agents") : Text("Merchants"),),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            ListTile(
              title: Text("Agent View"),
              onTap: () {
                setState(() {
                  agentView = true;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Merchant View"),
              onTap: () {
                setState(() {
                  agentView = false;
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: (_initialPosition == null)
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14.4746,
              ),
              onMapCreated: _onMapCreated,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              compassEnabled: true,
              markers: agentView ? agentMarkers : merchantMarkers,
              onCameraMove: (position) {
                print(position.target);
              },
            ),
    );
  }
}
