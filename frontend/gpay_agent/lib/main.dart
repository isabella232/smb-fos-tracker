import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:agent_app/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AgentApp());
}

///This is the root stateless widget of application. Calls stateful widget [StartAgentApp]
class AgentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome Agent',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartAgentApp(),
    );
  }
}

///Builds [StartAgentAppState]
class StartAgentApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StartAgentAppState();
  }
}

///Starts capturing GPS location of device. Redirects to [LoginView]
class StartAgentAppState extends State<StartAgentApp>{
  Geolocator _geolocator;
  Position _position;

  ///Checks the status of GPS granted by user
  ///locationAlways means GPS location will be traced when app is running either in background or foreground.
  ///locationWhenInUse means GPS location will be traced when this application is the running app.
  ///Default status will be granted if either of the two is granted
  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  }

  ///Initializes _goelocator and stream for listening changes in device location.
  ///Position will be changed if distance changes by [distanceFilter]
  @override
  void initState() {
    super.initState();

    _geolocator = Geolocator();
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    checkPermission();

    StreamSubscription<Position> positionStream = _geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          print("Starting to Listen!");
          _position = position;
          print(_position != null ? _position.latitude.toString() : '0');
          print(_position != null ? _position.longitude.toString() : '0');
        });
  }

  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
