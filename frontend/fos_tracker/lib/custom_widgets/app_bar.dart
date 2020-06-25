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

/// Creates custom app bar for views containing bar chart.
/// It has back button on the left and title in the centre.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Color appBarColor;
  @override
  final Size preferredSize = Size.fromHeight(60);

  CustomAppBar({this.appBarTitle, this.appBarColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0.0,
      bottomOpacity: 0.0,
      title: Text(
        appBarTitle,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
