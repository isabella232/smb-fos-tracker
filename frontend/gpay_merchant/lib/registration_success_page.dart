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
          Image.asset('images/tick.gif',
            width: MediaQuery.of(context).size.width * 0.9,),
          FittedBox(child: Text("Business registered successfully!",
            style: GoogleFonts.montserrat().copyWith(fontSize: 20),),),
        ],
      ),),)
    );
  }
}