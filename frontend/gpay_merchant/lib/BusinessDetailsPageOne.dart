import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'BusinessDetailsPageTwo.dart';
import 'Store.dart';
class BusinessDetailsPageOne extends StatefulWidget {
  BusinessDetailsPageOne({Key key, this.googleSignIn}) : super(key: key);
  GoogleSignIn googleSignIn;
  @override
  _BusinessDetailsPageOneState createState() => _BusinessDetailsPageOneState();
}

class _BusinessDetailsPageOneState extends State<BusinessDetailsPageOne> {  
    TextEditingController bname = TextEditingController();
    TextEditingController sname = TextEditingController();
    TextEditingController oname = TextEditingController();
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle styleBold = GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    TextStyle style = GoogleFonts.montserrat();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Form(key: _formKey, child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.01, width * 0.05, height * 0.05),
          child: ListView(
            children: <Widget>[
              Text("Business details (1/3)",
                style: styleBold.copyWith(
//                    fontSize: 12,
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              Text("Tell us more about your business",
                style: styleBold.copyWith(
//                    fontSize: 12,
                  color: Colors.black26,
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: (height * 0.03),
              ),
//               TextFormField(
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return "Cannot be empty";
//                   }
//                   return null;
//                 },
//                 controller: bname,
//                 style: style,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Registered business name',
//                   hintStyle: style,
//                 ),
//               ),
//               Text(
//                 "Eg. A-B-C Pvt Ltd",
//                 style: styleBold.copyWith(
// //                    fontSize: 12,
//                   color: Colors.black26,
//                   fontSize: 12,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: sname,
                style: style,
               validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Shop name',
                  hintStyle: style,
                ),
              ),
              Text(
                "Name that your customers will see",
                style: styleBold.copyWith(
//                    fontSize: 12,
                  color: Colors.black26,
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: oname,
                style: style,
                 validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Business owner\'s name',
                  hintStyle: style,
                ),
              ),
              Text(
                "Name of owner, director or partner",
                style: styleBold.copyWith(
//                    fontSize: 12,
                  color: Colors.black26,
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    //TODO: create store object and pass it
                    if (_formKey.currentState.validate()) {
                      Store store = Store(sname.text, widget.googleSignIn.currentUser.email, 0, null, null, null, bname.text, null, null, null, null, null, null, null, null);
                      Navigator.push(context, MaterialPageRoute( builder: (context) =>
                      BusinessDetailsPageTwo(googleSignIn: widget.googleSignIn, store: store,)));
                    }
                  },
                  child: Text(
                    "Next",
                    style: style,
                  ),
                )
              )
            ],
          ),
        ),
      ),)
    );
  }
}
