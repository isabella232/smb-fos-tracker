import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'globals.dart' as globals;
import 'select_business_page.dart';

class SignInHomePage extends StatefulWidget {
  @override
  _SignInHomePageState createState() => _SignInHomePageState();
}

/*
 * This class contains the view to allow the user to sign in with Google.
 */
class _SignInHomePageState extends State<SignInHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextStyle montserratBasicStyle = GoogleFonts.montserrat();
    TextStyle montserratBoldStyle =
        GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.05,
                screenHeight * 0.05, screenWidth * 0.05, screenHeight * 0.05),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: (screenHeight * 0.08),
                ),
                Image.asset(
                  'images/download.png',
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.05,
                ),
                SizedBox(height: (screenHeight * 0.01)),
                FittedBox(
                  child: Text(
                    "Welcome to Google Pay for Business",
                    style: montserratBoldStyle.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: (screenHeight * 0.01)),
                FittedBox(
                    child: Text(
                  "Receive payments directly to your bank account"
                  " without any fee",
                  style: montserratBasicStyle.copyWith(color: Colors.black38),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: (screenHeight * 0.04)),
                Image.asset(
                  'images/f8c422a0a0e6793b3f9113d419c5143a.gif',
                  height: (screenHeight * 0.4),
                ),
                SizedBox(height: (screenHeight * 0.08)),
                FittedBox(
                  child: Text(
                    "Sign in with the email that you used for Google "
                    "My Business to save\ntime filling in some details.",
                    style: montserratBasicStyle.copyWith(
//                    fontSize: 12,
                        color: Colors.black38),
                  ),
                ),
                SizedBox(height: (screenHeight * 0.015)),
                OutlineButton(
                  child: Image.asset(
                    'images/sign_in.png',
                    width: screenWidth * 0.8,
                  ),
                  onPressed: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
                    try {
                      await googleSignIn.signIn();
                      if (googleSignIn != null &&
                          googleSignIn.currentUser != null) {
                        if (googleSignIn.currentUser.displayName == null) {
                          await googleSignIn.signIn();
                        }
                        if (googleSignIn.currentUser.displayName != null) {
                          Navigator.pop(context);
                          globals.googleSignIn = googleSignIn;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectBusinessPage()));
                        }
                      }
                    } catch (e) {
                      print('There was an error with Google sign in' + e);
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
