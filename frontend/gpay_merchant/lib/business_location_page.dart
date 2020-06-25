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

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' hide Address;
import 'package:google_fonts/google_fonts.dart';

import 'address.dart';
import 'business_phone_page.dart';
import 'coordinates.dart' as definedCoordinates;
import 'globals.dart' as globals;
import 'location_confirm_on_map_page.dart';

class BusinessDetailsPageTwo extends StatefulWidget {
  @override
  _BusinessDetailsPageTwoState createState() => _BusinessDetailsPageTwoState();
}

/*
 * This class contains the view to accept the business address such as: street name, area, city and state.
 * It also redirects to a google maps page to confirm the location of the business.
 */
class _BusinessDetailsPageTwoState extends State<BusinessDetailsPageTwo> {
  TextEditingController pincodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  Coordinates selectedCoordinates;
  final formValidationKey = GlobalKey<FormState>();
  bool validate = false;
  bool isMapValid = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle styleBold = GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    TextStyle style = GoogleFonts.montserrat();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formValidationKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.05, height * 0.01, width * 0.05, height * 0.05),
              child: ListView(
                children: <Widget>[
                  Text(
                    "Business location (2/3)",
                    style: styleBold.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "put location and confirm on map",
                    style: styleBold.copyWith(
                      color: Colors.black26,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: (height * 0.03),
                  ),
                  TextFormField(
                    controller: pincodeController,
                    style: style,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Cannot be empty";
                      }
                      try {
                        var pincode = int.parse(value);
                        if (pincode < 100000 || pincode > 999999) {
                          return "Invalid Pincode";
                        }
                      } on FormatException {
                        return "Invalid Pincode";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'PIN code',
                      hintStyle: style.copyWith(color: Colors.black38),
                    ),
                  ),
                  SizedBox(
                    height: (height * 0.015),
                  ),
                  TextFormField(
                    controller: streetController,
                    style: style,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Shop number and street name',
                      hintStyle: style.copyWith(color: Colors.black38),
                    ),
                  ),
                  SizedBox(
                    height: (height * 0.015),
                  ),
                  TextFormField(
                    controller: areaController,
                    style: style,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Area/locality/village',
                      hintStyle: style,
                    ),
                  ),
                  SizedBox(
                    height: (height * 0.015),
                  ),
                  TextFormField(
                    controller: cityController,
                    style: style,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'City',
                      hintStyle: style,
                    ),
                  ),
                  SizedBox(
                    height: (height * 0.015),
                  ),
                  TextFormField(
                    controller: stateController,
                    style: style,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'State/County',
                      hintStyle: style,
                    ),
                  ),
                  SizedBox(
                    height: (height * 0.015),
                  ),
                  FloatingActionButton.extended(
                    icon: validate ? Icon(Icons.check) : Icon(Icons.map),
                    label: Text("Confirm on map"),
                    backgroundColor: isMapValid ? Colors.blue : Colors.red,
                    onPressed: () async {
                      if ((cityController.text == null ||
                              cityController.text.isEmpty) ||
                          (streetController.text == null ||
                              streetController.text.isEmpty)) {
                        globals.showAlertDialog(
                            "Error", "Select city and street", context);
                      } else {
                        final query =
                            streetController.text + ", " + cityController.text;
                        var addresses;
                        try {
                          addresses = await Geocoder.local
                              .findAddressesFromQuery(query);
                        } catch (err) {
                          globals.showAlertDialog("Error",
                              "Error with processing address", context);
                        }
                        var first = addresses.first;
                        Coordinates resultCoordinates = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapView(
                                      city: cityController.text,
                                      street: streetController.text,
                                      latitude: first.coordinates.latitude,
                                      longitude: first.coordinates.longitude,
                                    )));
                        setState(() {
                          selectedCoordinates = resultCoordinates;
                        });
                        globals.showAlertDialog(
                            "Success", "Location Selected", context);
                        setState(() {
                          validate = true;
                          isMapValid = true;
                        });
                      }
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (formValidationKey.currentState.validate() &&
                              validate) {
                            globals.store.storeAddress = new Address(
                                streetController.text,
                                areaController.text,
                                cityController.text,
                                stateController.text,
                                pincodeController.text,
                                "India");
                            globals.store.coordinates =
                                new definedCoordinates.Coordinates(
                                    selectedCoordinates.latitude,
                                    selectedCoordinates.longitude);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BusinessDetailsPageThree()));
                          } else
                            setState(() {
                              isMapValid = false;
                            });
                          ;
                        },
                        child: Text(
                          "Next",
                          style: style,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
