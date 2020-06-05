import 'package:flutter/material.dart';
import 'package:verification/business_verification_menu_items.dart';
import 'package:verification/business_verification_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verification/business_verification_failure_view.dart';


class verificationPage1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verification',
      theme: ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
    ),
      home: VerificationHomePage1(),
    );
  }
}

class VerificationHomePage1 extends StatefulWidget {
  VerificationHomePage1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VerificationPage1State createState() => _VerificationPage1State();
}

class _VerificationPage1State extends State<VerificationHomePage1> {

  void choiceAction(String choice){
    if(choice == MenuItems.Cancel) {
      print('Discard Verification');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => verificationFailed()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: ()   {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return MenuItems.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],*/
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Container(
            height: 50.0,
            child: const Center(
              child: Text(
                'Merchant details',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Image.asset('assets/shop.png'),
          Container(
            height: 50.0,
            child: const Center(
              child: Text(
                'Merchant Name : ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            height: 50.0,
            child: const Center(
              child: Text(
                'Store Name : ',
                textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
              ),
            )
        ]
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VerificationPage2()));
        },
        tooltip: 'Next',
        shape: RoundedRectangleBorder(),
        label: Text(
          'Next',
          style: TextStyle(
              fontSize: 16.0
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
