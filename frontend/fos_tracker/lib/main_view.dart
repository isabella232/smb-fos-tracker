import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fos_tracker/agent_and_merchant_info_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'agent.dart';
import 'globals.dart' as globals;
import 'store.dart';

/*
  This class contains the UI for the main map view that is generated on app launch.
 */
class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Completer<GoogleMapController> controller;
  bool agentView = true;
  bool httpDone = true;

  void initState() {
    _getUserLocation();
    getAgentLocations();
    getMerchantLocations();
    super.initState();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      globals.startPosition = LatLng(position.latitude, position.longitude);
    });
  }

  _onMapCreated(GoogleMapController controllerArg) async {
    setState(() {
      controller.complete(controllerArg);
    });
  }

  void getAgentLocations() async {
    var result =
        await http.get("https://fos-tracker-278709.an.r.appspot.com/agents");

    if (result.statusCode == 200) {
      LineSplitter lineSplitter = new LineSplitter();
      List<String> lines = lineSplitter.convert(result.body);
      for (var x in lines) {
        if (x != 'Successful') {
          Agent agent = Agent.fromJson(jsonDecode(x));
          setState(() {
            globals.agentMarkers.add(
              Marker(
                  markerId: MarkerId(agent.email),
                  position: LatLng(
                      agent.coordinates.latitude, agent.coordinates.longitude),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgentPage(
                                  agentEmail: agent.email,
                                )));
                  },
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen)),
            );
          });
        }
      }
    }
  }

  void getMerchantLocations() async {
    var result = await http
        .get("https://fos-tracker-278709.an.r.appspot.com/stores/status");
    if (result.statusCode == 200) {
      LineSplitter lineSplitter = new LineSplitter();
      List<String> lines = lineSplitter.convert(result.body);
      for (var x in lines) {
        if (x != 'Successful') {
          Store store = Store.fromJson(jsonDecode(x));
          setState(() {
            globals.merchantMarkers.add(
              Marker(
                  markerId: MarkerId(store.storePhone),
                  position: LatLng(
                      store.coordinates.latitude, store.coordinates.longitude),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MerchantPage(
                                  storePhone: store.storePhone,
                                )));
                  },
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      store.status == 'grey'
                          ? BitmapDescriptor.hueYellow
                          : (store.status == 'green'
                              ? BitmapDescriptor.hueGreen
                              : BitmapDescriptor.hueRed))),
            );
          });
        }
      }
    }
  }

  void updateMarker() async {
    setState(() {
      httpDone = false;
    });
    List<Agent> newAgents = [];
    var result =
        await http.get("https://fos-tracker-278709.an.r.appspot.com/agents");
    if (result.statusCode == 200) {
      LineSplitter lineSplitter = new LineSplitter();
      List<String> lines = lineSplitter.convert(result.body);
      for (var x in lines) {
        if (x != 'Successful') {
          Agent agent = Agent.fromJson(jsonDecode(x));
          newAgents.add(agent);
        }
      }
    }

    for (var x in newAgents) {
      setState(() {
        globals.agentMarkers.removeWhere((m) => m.markerId.value == x.email);
        globals.agentMarkers.add(Marker(
            markerId: MarkerId(x.email),
            position: LatLng(x.coordinates.latitude, x.coordinates.longitude),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgentPage(
                            agentEmail: x.email,
                          )));
            },
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)));
      });
    }
    setState(() {
      httpDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const oneSec = const Duration(milliseconds: 500);
    new Timer.periodic(oneSec, (Timer t) => httpDone ? updateMarker() : null);
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
              ),
        bottomNavigationBar: !agentView
            ? BottomNavigationBar(
                items: [
                  new BottomNavigationBarItem(
                      icon: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                      ),
                      title: Text(
                        "failed",
                      )),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.brightness_1, color: Colors.yellow),
                      title: Text("incomplete")),
                  new BottomNavigationBarItem(
                      icon: Icon(Icons.brightness_1, color: Colors.lightGreen),
                      title: Text("successful"))
                ],
                selectedLabelStyle: TextStyle(color: Colors.black),
                selectedItemColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Colors.black),
                unselectedItemColor: Colors.black,
              )
            : null);
  }
}
