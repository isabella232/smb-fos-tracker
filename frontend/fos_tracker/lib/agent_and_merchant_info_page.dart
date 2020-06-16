import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'globals.dart' as globals;

class AgentPage extends StatefulWidget {
  final String agentEmail;

  AgentPage({Key key, @required this.agentEmail}) : super(key: key);

  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  //TODO: fetch agent verifications
  Completer<GoogleMapController> controller;
  String agentFirstName;
  String agentName;
  String agentPhone;
  String agentCreationTime;

  _onMapCreated(GoogleMapController controllerArg) async {
    setState(() {
      controller.complete(controllerArg);
    });
  }

  @override
  void initState() {
    getAgentInfo();
    super.initState();
  }

  Future<void> getAgentInfo() async {
    var result = await http.post(
        "https://fos-tracker-278709.an.r.appspot.com/agent/email",
        body: jsonEncode(<String, String>{"agentEmail": widget.agentEmail}));
    if (result.statusCode != 200) {
      setState(() {});
    } else {
      try {
        LineSplitter lineSplitter = new LineSplitter();
        List<String> lines = lineSplitter.convert(result.body);
        String json = lines[0];
        var jsonDecoded = jsonDecode(json);
        setState(() {
          agentFirstName = jsonDecoded['name']['firstName'];
          agentName = jsonDecoded['name']['firstName'] +
              ' ' +
              jsonDecoded['name']['middleName'] +
              ' ' +
              jsonDecoded['name']['lastName'];
          agentPhone = jsonDecoded['phone'];
          agentCreationTime = jsonDecoded['agentCreationDateTime'];
        });
      } catch (e) {
        print(e + "error parsing agent info");
      }
    }
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
          child: agentFirstName == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Name: " + agentName),
                    Text("Phone: " + agentPhone),
                    Text("Email: " + widget.agentEmail),
                    Text("Time of creation: " + agentCreationTime)
                  ],
                ),
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
          onCameraMove: (position) {},
        ),
        collapsed: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.keyboard_arrow_up),
              (agentFirstName == null || agentFirstName.isEmpty)
                  ? Text(" Swipe up to view agent info")
                  : Text(" Swipe up to view " + agentFirstName + "'s info"),
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
  String storeName;
  String ownerName;
  String email;
  String storeCreationTime;
  String address;

  @override
  void initState() {
    getMerchantInfo();
    super.initState();
  }

  Future<void> getMerchantInfo() async {
    var result = await http.post(
        "https://fos-tracker-278709.an.r.appspot.com/store/phone",
        body: jsonEncode(<String, String>{"storePhone": widget.storePhone}));
    if (result.statusCode != 200) {
      setState(() {});
    } else {
      try {
        LineSplitter lineSplitter = new LineSplitter();
        List<String> lines = lineSplitter.convert(result.body);
        String json = lines[0];
        var jsonDecoded = jsonDecode(json);
        setState(() {
          storeName = jsonDecoded['storeName'];
          ownerName = jsonDecoded['ownerName']['firstName'] +
              ' ' +
              jsonDecoded['ownerName']['middleName'] +
              ' ' +
              jsonDecoded['ownerName']['lastName'];
          storeCreationTime = jsonDecoded['creationDateTime'];
          address = jsonDecoded['storeAddress']['street'] +
              "\n" +
              jsonDecoded['storeAddress']['area'] +
              "\n" +
              jsonDecoded['storeAddress']['city'] +
              "\n" +
              jsonDecoded['storeAddress']['state'] +
              "\n" +
              jsonDecoded['storeAddress']['pincode'] +
              "\n" +
              jsonDecoded['storeAddress']['country'];
        });
      } catch (e) {
        print(e + "error parsing merchant info");
      }
    }
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
          title: Text(widget.storePhone),
        ),
        body: storeName == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      storeName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Owner: " + ownerName,
                    ),
                    Text(
                      "Phone: " + widget.storePhone,
                    ),
                    Text(
                      "Address: " + address,
                    ),
                    Text(
                      "Creation time: " + storeCreationTime,
                    ),
                  ],
                ),
              ));
  }
}
