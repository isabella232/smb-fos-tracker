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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fos_tracker/data_models/store_in_agent_path.dart';
import 'package:fos_tracker/path_views/agent_path.dart';
import 'package:http/http.dart' as http;

/// Class for creating state of view for selecting agent whose path is to be found.
class SelectAgent extends StatefulWidget {
  @override
  SelectAgentState createState() => SelectAgentState();
}

class SelectAgentState extends State<SelectAgent> {
  bool _loading = false;
  String agentEmail;
  String errorMessage = "";
  List<StoreForAgentPath> storesInPath;
  final _formKey = GlobalKey<FormState>();

  // Initializing loading state to false and loading will start when the agent email is entered and http request for fetching his/her details is being made.
  @override
  void initState() {
    super.initState();
    _loading = false;
    errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Enter the email of agent"),
            Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      // Validator checks if the entered email is not empty and is of the form of an email.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          // Regular expression for checking if the email entered is a valid email
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Please enter a valid email';
                          } else {
                            agentEmail = value.trim();
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // In case the string entered by user is of the form of an email, make http request.
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        getStoreVerifiedByAgent();
                      }
                    },
                    child: Text('Fetch Path'),
                  ),
                ])),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            // In case the page is in loading state, i.e. http post request is being made in the background, it shows a circular progress bar, otherwise it shows an empty string
            Container(
              child: _loading ? new CircularProgressIndicator() : Text(""),
            )
          ],
        ),
      ),
    );
  }

  /// Makes request to server to get the stores verified by the agent email entered by user.
  /// In case found some stores corresponding to the agent entered, sort them is the order of increasing verification time.
  /// This order is used to plot an estimate path that may have been taken by agent to verify stores.
  /// After completion it sets the loading state to false so that circular progress indicator does not appear on screen anymore.
  Future<void> getStoreVerifiedByAgent() async {
    storesInPath = new List();
    final http.Response response = await http.post(
      'https://fos-tracker-278709.an.r.appspot.com/agent/stores/status/verificationtime',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "agentEmail": agentEmail,
      }),
    );

    // In case http request is successful
    if (response.statusCode == 200) {
      LineSplitter lineSplitter = new LineSplitter();
      List<String> storesList = lineSplitter.convert(response.body);
      for (var storeJson in storesList) {
        if (storeJson == "Successful") {
          continue;
        }
        StoreForAgentPath storeForAgentPath =
            StoreForAgentPath.fromJson(jsonDecode(storeJson));
        storesInPath.add(storeForAgentPath);
      }

      // Sorting on the basis of time of verification
      storesInPath.sort((StoreForAgentPath store1, StoreForAgentPath store2) {
        DateTime store1Date = DateTime.parse(store1.verificationDateTime);
        DateTime store2Date = DateTime.parse(store2.verificationDateTime);
        return store1Date.compareTo(store2Date);
      });

      setState(() {
        errorMessage = "";
        _loading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentPathPage(
              agentEmail: agentEmail,
              storesInPath: storesInPath,
            ),
          ));
    } else {
      print("unsuccessful request");
      setState(() {
        errorMessage = "Failed to reach server";
        _loading = false;
      });
    }
  }
}
