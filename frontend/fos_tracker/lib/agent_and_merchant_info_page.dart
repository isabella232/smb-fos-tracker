import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'globals.dart' as globals;

class AgentPage extends StatefulWidget {
  final String agentEmail;

  AgentPage({Key key, @required this.agentEmail}) : super(key: key);

  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  //TODO: fetch agent info
  //TODO: fetch agent verifications
  Completer<GoogleMapController> controller;

  _onMapCreated(GoogleMapController controllerArg) async {
    setState(() {
      controller.complete(controllerArg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.agentEmail),
      ),
      body: SlidingUpPanel(
        backdropEnabled: true,
        panel: Center(
          child: Text("Agent Info will be displayed here."),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: globals.startPosition,
            zoom: 14.4746,
          ),
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          onCameraMove: (position) {
            print(position.target);
          },
        ),
        collapsed: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.keyboard_arrow_up),
              Text(" Swipe up to view agent info"),
              Icon(Icons.keyboard_arrow_up)
            ],
          ),
        ),
        minHeight: MediaQuery.of(context).size.height * 0.06,
      ),
    );
  }
}

class MerchantPage extends StatefulWidget {
  final String storePhone;

  MerchantPage({Key key, @required this.storePhone}) : super(key: key);

  @override
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.storePhone),
      ),
      body: Center(child: Text("Merchant info will appear here")),
    );
  }
}
