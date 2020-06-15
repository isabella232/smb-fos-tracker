import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fos_tracker/agent_and_merchant_info_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'globals.dart' as globals;

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Completer<GoogleMapController> controller;
  bool agentView = true;
  LatLng loc = globals.startPosition;
  LatLng loc1 = globals.startPosition;

  //TODO: use actual coordinates
  void initState() {
    _getUserLocation();
    for (var x in globals.agentCoordinates) {
      globals.agentMarkers.add(
        Marker(
            markerId: MarkerId(x.longitude.toString()),
            position: x,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgentPage(
                        //TODO: change to email
                            agentEmail: x.longitude.toString(),
                          )));
            },
//            icon: BitmapDescriptor.fromAsset("images/agent.png")
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)),
      );
    }
    for (var x in globals.merchantCoordinatesFailed) {
      globals.merchantMarkers.add(
        Marker(
          markerId: MarkerId(x.longitude.toString()),
          position: x,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MerchantPage(
                      //TODO: change to phone
                          storePhone: x.longitude.toString(),
                        )));
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//            icon: BitmapDescriptor.fromAsset(
//              "images/merchant.png",
//            )
        ),
      );
    }
    for (var x in globals.merchantCoordinatesIncomplete) {
      globals.merchantMarkers.add(
        Marker(
          markerId: MarkerId(x.longitude.toString()),
          position: x,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MerchantPage(
                          storePhone: "9831261065",
                        )));
          },
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
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
    setState(() {
      globals.startPosition = LatLng(position.latitude, position.longitude);
      loc = globals.startPosition;
      loc1 = globals.startPosition;
      globals.agentMarkers
          .add(Marker(markerId: MarkerId("Vanshika"), position: loc));
      globals.agentMarkers
          .add(Marker(markerId: MarkerId("Vanshika1"), position: loc1));
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
        globals.agentMarkers.removeWhere((m) => m.markerId.value == "Vanshika");
        globals.agentMarkers.add(Marker(
          markerId: MarkerId("Vanshika"),
          position: loc, // updated position
        ));
        globals.agentMarkers
            .removeWhere((m) => m.markerId.value == "Vanshika1");
        globals.agentMarkers.add(Marker(
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
        appBar: AppBar(
          title: agentView ? Text("Agents") : Text("Merchants"),
        ),
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
        body: (globals.startPosition == null)
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: globals.startPosition,
                  zoom: 14.4746,
                ),
                onMapCreated: _onMapCreated,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                markers:
                    agentView ? globals.agentMarkers : globals.merchantMarkers,
                onCameraMove: (position) {
                  print(position.target);
                },
              ),
        bottomNavigationBar: !agentView
            ? BottomNavigationBar(
                items: [
                  new BottomNavigationBarItem(
                      icon: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                      ),
                      title: Text("Verification failed")),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.brightness_1, color: Colors.yellow),
                      title: Text("Verification incomplete"))
                ],
              )
            : null);
  }
}
