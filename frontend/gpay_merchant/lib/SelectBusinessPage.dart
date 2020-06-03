import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'globals.dart' as globals;
import 'BusinessDetailsPageOne.dart';
import 'SignInHomePage.dart';

class SelectBusinessPage extends StatefulWidget {
  @override
  _SelectBusinessPageState createState() => _SelectBusinessPageState();
}

class _SelectBusinessPageState extends State<SelectBusinessPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle styleBold = GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    TextStyle style = GoogleFonts.montserrat();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                print(e);
              }
              print('HI\n');
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInHomePage()));
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Padding (
            padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.01, width * 0.05, height * 0.05),
            child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: Text(((globals.googleSignIn.currentUser.displayName) != null ?
                  globals.googleSignIn.currentUser.displayName.split(" ").first
                      + ", set up your business" : "Set up your business"),
                    style: styleBold.copyWith(
//                    fontSize: 12,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                //TODO: Load existing businesses
                SizedBox(height: (height * 0.01),),
                Row(
                  children: <Widget>[
                    IconButton (
                      icon: Icon(Icons.add_circle_outline, size: height * 0.05,),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                BusinessDetailsPageOne()));
                      },
                    ),
                    SizedBox(width: (width * 0.1),),
                    Text("Add a new business", style: style.copyWith(color: Colors.black), textAlign: TextAlign.center,)
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
  Future<void> logout() async {
    await globals.googleSignIn.signOut();
  }
}
