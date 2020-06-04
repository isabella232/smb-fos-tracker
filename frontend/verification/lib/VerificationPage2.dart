import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verification/menuItems.dart';
import 'package:verification/verificationSuccess.dart';
import 'package:verification/verificationFailed.dart';

//class verificationPage2 extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        textTheme: GoogleFonts.montserratTextTheme(
//          Theme.of(context).textTheme,
//        ),
//      ),
//      home: VerificationHomePage2(),
//    );
//  }
//}

class VerificationPage2 extends StatefulWidget {
//  VerificationHomePage2({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _VerificationPage2State createState() => _VerificationPage2State();
}

class _VerificationPage2State extends State<VerificationPage2> {
  bool isStorePresent = false;
  bool isBusinessPresent = false;

  void choiceAction(String choice){
    if(choice == MenuItems.Cancel) {
      print('Discard Verification');
      //When ever user clicks on discard verification it opens up verification failed
      //TODO: Need to return to home page after cancelling verification
      _showCancelVerificationDialog();

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

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          onPressed:(){
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
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
              height: 50.0,
              child: const Center(
                child: Text(
                  'Verification details',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Row(
                  children: <Widget> [
                    Text(
                      'Does store exist ?',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Switch(
                      value: isStorePresent,
                      onChanged: (value) {
                        setState(() {
                          isStorePresent = value;
                          print(isStorePresent);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                      inactiveTrackColor: Colors.red,
                    ),
                  ]
              ),
            ),
            Container(
              height: 50.0,
              child: Center(
                child: Row(
                    children: <Widget> [
                      Text(
                        'Does business exist ?',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Switch(
                        value: isBusinessPresent,
                        onChanged: (value) {
                          setState(() {
                            isBusinessPresent= value;
                            print(isBusinessPresent);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                        inactiveTrackColor: Colors.red,
                      ),
                    ]
                ),
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          _showVerifyDialog();
        },
        tooltip: 'Verify',
        shape: RoundedRectangleBorder(),
        elevation: 0.0,
        label: Text(
          'Verify',
          style: TextStyle(
              fontSize: 16.0,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _verifyMerchant(){
    if(isBusinessPresent & isStorePresent) {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => verificationSuccess()));
    }
    else{
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => verificationFailed()));
    }
  }

  Future<void> _showVerifyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
//                Text('Make sure above information is correct before verifying'),
                Text('Verify the merchant'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('VERIFY'),
              onPressed: () {
                _verifyMerchant();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCancelVerificationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
//                Text('Make sure above information is correct before verifying'),
                Text('Delete the verification'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('DELETE'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => verificationFailed()));
              },
            ),
          ],
        );
      },
    );
  }

}

