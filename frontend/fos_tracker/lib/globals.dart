library fos_tracker.globals;

import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng startPosition;
Set<Marker> agentMarkers = new Set();
Set<Marker> merchantMarkers = new Set();

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
List<LatLng> merchantCoordinatesFailed = [
  LatLng(22.532372, 88.363407),
  LatLng(22.525558, 88.369540),
  LatLng(22.527316, 88.362249),
  LatLng(22.527125, 88.368211),
];

List<LatLng> merchantCoordinatesIncomplete = [
  LatLng(22.532232, 88.353498),
  LatLng(22.524458, 88.369430),
  LatLng(22.529716, 88.362233),
  LatLng(22.527140, 88.368200)
];
