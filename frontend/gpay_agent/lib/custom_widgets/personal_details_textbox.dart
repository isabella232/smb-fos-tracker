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
import 'package:flutter/painting.dart';

/// Defines a custom text box for personal details of agents and
/// merchants. [title] of every text box is the type of personal details it
/// represents like "Name", "Email", "Phone Number". [value] is the
/// personal detail particular to an agent or merchant or store.
class PersonalDetailsTextBox extends StatelessWidget {
  final String title;
  final String value;
  final Icon icon;

  PersonalDetailsTextBox({this.title, this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  this.value,
                  textAlign: TextAlign.left,
                )
              ],
            ),
            IconButton(
              icon: icon,
            ),
          ],
        ));
  }
}
