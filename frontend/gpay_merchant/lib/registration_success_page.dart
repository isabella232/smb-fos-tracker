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
import 'package:google_fonts/google_fonts.dart';

class FinalPage extends StatefulWidget {
  @override
  FinalPageState createState() => FinalPageState();
}

/*
 * This class contains the view to inform the user that
 * he business has been registered.
 */
class FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.black26,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/tick.gif',
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                FittedBox(
                  child: Text(
                    "Business registered successfully!",
                    style: GoogleFonts.montserrat().copyWith(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
