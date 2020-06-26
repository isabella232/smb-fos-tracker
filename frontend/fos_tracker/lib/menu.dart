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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fos_tracker/charts_views/verification_analysis_time_wise.dart';
import 'package:fos_tracker/charts_views/verification_analysis_region_wise.dart';
import 'package:fos_tracker/main_view.dart';
import 'package:fos_tracker/path_views/select_agent.dart';

/// Class for rendering the main menu page having option for either tracking live location of agents or viewing verification status charts based on region and week or getting path of agent.
class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                child: Image.asset("images/menu_logo.png"),
              ),
              CustomButton(
                title: "Agent Live Tracking",
                icon: Icon(
                  Icons.add_location,
                  color: Colors.white,
                  size: 30,
                ),
                function: new MainView(),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: "Verification Analysis By Region",
                icon: Icon(
                  Icons.insert_chart,
                  color: Colors.white,
                  size: 30,
                ),
                function: new RegionalAnalysis(),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: "Verification Analysis By Week",
                icon: Icon(
                  Icons.date_range,
                  color: Colors.white,
                  size: 30,
                ),
                function: new TimeAnalysis(),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: "Retrieve Agent Path",
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 30,
                ),
                function: new SelectAgent(),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

/// Class for creating custom button structure
class CustomButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final StatefulWidget function;

  CustomButton({this.title, this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: ButtonTheme(
        height: 70,
        buttonColor: Colors.blue,
        child: RaisedButton(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              icon,
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => function,
                ));
          },
        ),
      ),
    );
  }
}
