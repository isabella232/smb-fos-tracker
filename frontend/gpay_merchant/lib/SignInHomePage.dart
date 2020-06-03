import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpay_merchant/SignInButton.dart';
import 'SelectBusinessPage.dart';
import 'SignInButton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'globals.dart' as globals;
class SignInHomePage extends StatefulWidget {
  @override
  _SignInHomePageState createState() => _SignInHomePageState();
}

class _SignInHomePageState extends State<SignInHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle style = GoogleFonts.montserrat();
    TextStyle styleBold = GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding (
//            padding: const EdgeInsets.all(25),
            padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.05, width * 0.05, height * 0.05),
            child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: (height * 0.1),),
                Image.asset(
                  'images/download.png',
//              height: height * 0.3,
                  width: width * 0.2,
                ),
                SizedBox(height: (height * 0.01)),
                FittedBox(
                  child: Text("Welcome to Google Pay for Business",
                    style: styleBold.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),),
                SizedBox(height: (height * 0.01)),
                FittedBox(
                    child: Text("Receive payments directly to your bank account"
                        " without any fee",
                      style: style.copyWith(
//                    fontSize: 12,
                          color: Colors.black38),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(height: (height * 0.05)),
                Image.asset('images/f8c422a0a0e6793b3f9113d419c5143a.gif',
                  height: (height * 0.4),
//                width: (width),
                ),
                SizedBox(height: (height * 0.08)),
                FittedBox(
                  child: Text("Sign in with the email that you used for Google "
                      "My Business to save\ntime filling in some details.",
                    style: style.copyWith(
//                    fontSize: 12,
                        color: Colors.black38),
                  ),
                ),
//            FittedBox(
//              child: Text( "time filling in some details.",
//                style: style.copyWith(
////                    fontSize: 12,
//                    color: Colors.black38),
//              ),
//            ),
                SizedBox(height: (height * 0.015)),
                SignInButtonBuilder(
                  image: Image.asset('images/google_icon_2048-715x715.png',
//                height: 40,
                    width: (width * 0.1),
                  ),
                  text: 'Sign in with Google',
                  textColor: Colors.black,
                  backgroundColor: Color(0xfff5ffff),
//                backgroundColor: Colors.white,
                  onPressed: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
                    try {
                      await googleSignIn.signIn();
                      if (googleSignIn != null
                          && googleSignIn.currentUser != null) {
                        if (googleSignIn.currentUser.displayName == null) {
                          await googleSignIn.signIn();
                        }
                        if (googleSignIn.currentUser.displayName != null) {
                          print(googleSignIn.currentUser.displayName);
                          print(googleSignIn.currentUser.displayName);
                          Navigator.pop(context);
                          globals.googleSignIn = googleSignIn;
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  SelectBusinessPage()
                          )
                          );
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  height: (height * 0.06),
                  width: width * 0.9,
                  elevation: 2,
                ),

              ],
            )),
      ),
    );
  }
}


