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

library fos_tracker.globals;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng startPosition;
Set<Marker> agentMarkers = new Set();
Set<Marker> merchantMarkers = new Set();
Set<Marker> verifiedMerchantMarkers = new Set();
LatLng currentPosition;
String pincode;

showAlertDialog(String title, String alertMessage, BuildContext context) {
  // This is the setup of the button to give user the choice to click on OK after reading the dialog.
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // This is the setup of the alert dialog based on the provided title.
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(
      alertMessage,
    ),
    actions: [
      okButton,
    ],
  );

  // This is where the alert dialog is displayed.
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
