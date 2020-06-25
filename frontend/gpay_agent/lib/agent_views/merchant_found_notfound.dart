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

import 'package:agent_app/agent_datamodels/text_widget.dart';
import 'package:agent_app/business_verification_views/business_verification_view.dart';
import 'package:agent_app/custom_widgets/personal_details_textbox.dart';
import 'package:agent_app/custom_widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:agent_app/globals.dart' as globals;

/// Builds UI if store searched for is not found in database.
class MerchantNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(globals.agent.getName(), Colors.white, context),
      body: ListView(children: <Widget>[
        Container(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextWidget(name: "Merchant Not Found", color: Colors.black),
              Image.asset(
                "assets/agent_beginning_images/not_found.gif",
                height: 150,
              ),
              ButtonTheme(
                minWidth: 250,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: new Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

/// Builds UI if store searched for is found in database.

class MerchantFound extends StatelessWidget {
  MerchantFound({this.name});

  String name = globals.store.ownerName.getName();
  int milliseconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(globals.agent.getName(), Colors.white, context),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
              child: TextWidget(name: "Merchant Found", color: Colors.black)),
          SizedBox(
            height: 10,
          ),
          PersonalDetailsTextBox(
            title: "Merchant Name",
            value: name,
            icon: Icon(Icons.face),
          ),
          SizedBox(
            height: 10,
          ),
          PersonalDetailsTextBox(
            title: "Store Phone",
            value: globals.store.phone,
            icon: Icon(Icons.phone),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/agent_beginning_images/tick.gif",
            height: 300,
          ),
          SizedBox(
            height: 10,
          ),
          ButtonTheme(
            minWidth: 200,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationHomeView(),
                  ),
                );
              },
              textColor: Colors.white,
              color: Colors.blue,
              child: new Text("Start Verification"),
            ),
          ),
        ],
      ),
    );
  }
}