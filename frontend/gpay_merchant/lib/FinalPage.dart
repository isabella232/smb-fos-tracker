import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FinalPage extends StatefulWidget {
  @override
  FinalPageState createState() => FinalPageState();
}
class FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
//    showAlertDialog(String title, String alertMessage, BuildContext context) {
//
//      // set up the button
//      Widget okButton = FlatButton(
//        child: Text("OK"),
//        onPressed: () {
//          Navigator.of(context).pop();
//        },
//      );
//
//      // set up the AlertDialog
//      AlertDialog alert = AlertDialog(
//        title: Text(title),
//        content: Text(alertMessage, style: GoogleFonts.montserrat(),),
//        actions: [
//          okButton,
//        ],
//      );
//
//      // show the dialog
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return alert;
//        },
//      );
//    }
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.home, color: Colors.black26,),
         onPressed: () {
           Navigator.pop(context);
         },
         ),),
      backgroundColor: Colors.white,
      body: Center(child: Container(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/tick.gif', width: MediaQuery.of(context).size.width * 0.9,),
          FittedBox(child: Text("Business registered succesfully!", style: GoogleFonts.montserrat().copyWith(fontSize: 20),),),
//          IconButton(
//            icon: Icon(Icons.settings_ethernet, color: Colors.black,),
//            onPressed: () async {
//              var result = await http.get("http://127.0.0.1:8080/hello", headers: {
//                          HttpHeaders.acceptHeader: "application/json"
//                        });
//              print(result.body);
//              showAlertDialog("success", "result was :" + result.body, context);
//            },
//          )
          
        ],
      ),),)
    );
  }
}