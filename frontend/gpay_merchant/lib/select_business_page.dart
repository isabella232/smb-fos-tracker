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

import 'business_basic_details_page.dart';
import 'globals.dart' as globals;
import 'sign_in_home_page.dart';

class SelectBusinessPage extends StatefulWidget {
  @override
  _SelectBusinessPageState createState() => _SelectBusinessPageState();
}

/*
 * This class provides the view for the user to create a new business.
 */
class _SelectBusinessPageState extends State<SelectBusinessPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle montserratBoldStyle =
        GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    TextStyle montserratBasicStyle = GoogleFonts.montserrat();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () async {
              try {
                await globals.googleSignIn.signOut();
                globals.googleSignIn = null;
              } catch (e) {
                print("There was an error with Google sign out" + e);
              }
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInHomePage()));
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.01,
            screenWidth * 0.05, screenHeight * 0.05),
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Text(
                ((globals.googleSignIn.currentUser.displayName) != null
                    ? globals.googleSignIn.currentUser.displayName
                            .split(" ")
                            .first +
                        ", set up your business"
                    : "Set up your business"),
                style: montserratBoldStyle.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            //TODO: Load existing businesses
            SizedBox(
              height: (screenHeight * 0.01),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: screenHeight * 0.05,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusinessDetailsPageOne()));
                  },
                ),
                SizedBox(
                  width: (screenWidth * 0.1),
                ),
                Text(
                  "Add a new business",
                  style: montserratBasicStyle.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  Future<void> logout() async {
    await globals.googleSignIn.signOut();
  }
}
