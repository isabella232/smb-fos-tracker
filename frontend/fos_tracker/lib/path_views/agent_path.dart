import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fos_tracker/coordinates.dart';
import 'package:fos_tracker/data_models/store_in_agent_path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;


class AgentPathPage extends StatefulWidget {
  final String agentEmail;
  final List<StoreForAgentPath> storesInPath;

  AgentPathPage({this.agentEmail, this.storesInPath});

  @override
  AgentPathPageState createState() => AgentPathPageState();
}

class AgentPathPageState extends State<AgentPathPage>{
  LatLng sourceLocation;
  LatLng destinationLocation;

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPIKey = "AIzaSyDgxU6ChEGPqjWnDiw0olP9utUFZEKylD0";

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  BitmapDescriptor storeSuccessFul, storeFailed, storeRevisit, storeUnvisited;



  @override
  void initState() {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Printing Something !!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("Initializing State");
    Coordinates startCoordinates = widget.storesInPath.first.coordinates;
    Coordinates endCoordinates = widget.storesInPath.last.coordinates;

    sourceLocation = new LatLng(startCoordinates.latitude, startCoordinates.longitude);
    destinationLocation = new LatLng(endCoordinates.latitude, endCoordinates.longitude);



    super.initState();
    setSourceDestinationStoreIcons();
  }

  void setSourceDestinationStoreIcons() async {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Printing Something !!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("Setting source and destination coordinates");

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/start.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/end.png');
    storeSuccessFul = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/m_green.png');
    storeFailed = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/m_red.png');
    storeRevisit = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/m_yellow.png');
    storeUnvisited = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/m_grey.png');

  }

  @override
  Widget build(BuildContext context) {

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Printing Something !!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("Building view");
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: sourceLocation
    );

    print(initialLocation);

    return GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        tiltGesturesEnabled: false,
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        onMapCreated: onMapCreated
    );

  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }


  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: sourceLocation,
          icon: sourceIcon
      ));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destinationLocation,
          icon: destinationIcon
      ));

      widget.storesInPath.forEach((StoreForAgentPath store) {
        print(store.storePhone);
        print(store.coordinates.latitude);
        print(store.coordinates.longitude);

        _markers.add(Marker(
          markerId: MarkerId(store.storePhone + " " + store.verificationTime),
          position: new LatLng(store.coordinates.latitude, store.coordinates.longitude),
              icon: store.status == 'grey'
                  ? storeUnvisited
                  : (store.status == 'green'
                  ? storeSuccessFul
                  : (store.status == 'yellow'
                  ? storeRevisit
                  : storeFailed))),
        );
      });
    });
  }

  setPolylines() async {
    print("setting polylines --------------------------------------------------------------------------------------------------------------------------------------------->");
    List<PointLatLng> result = new List();
    for(int i = 0; i < widget.storesInPath.length; i ++){
      print(i);
      print(widget.storesInPath[i].coordinates.latitude);
      print(widget.storesInPath[i].coordinates.longitude);
    }
    for(int i = 0; i < widget.storesInPath.length - 1; i ++){
      LatLng source = LatLng(widget.storesInPath[i].coordinates.latitude, widget.storesInPath[i].coordinates.longitude);
      LatLng destination = LatLng(widget.storesInPath[i + 1].coordinates.latitude, widget.storesInPath[i + 1].coordinates.longitude);
      print("Getting route between ");
      print(source);
      print(destination);
      List<PointLatLng> pathList = await
      polylinePoints?.getRouteBetweenCoordinates(
          googleAPIKey,
          source.latitude,
          source.longitude,
          destination.latitude,
          destination.longitude);
      print("Printing pathList");
      print(pathList);
      result += pathList;
      print("Printing result");
    }
    print(result);
    if(result.isNotEmpty){
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point){
        polylineCoordinates.add(
            LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates
      );

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}

