import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'globals.dart' as globals;

import 'BusinessDetailsPageTwo.dart';
import 'Store.dart';
class BusinessDetailsPageOne extends StatefulWidget {
  @override
  _BusinessDetailsPageOneState createState() => _BusinessDetailsPageOneState();
}

class _BusinessDetailsPageOneState extends State<BusinessDetailsPageOne> {  
    TextEditingController storeNameController = TextEditingController();
    TextEditingController ownerNameController = TextEditingController();
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
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: storeNameController,
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
                controller: ownerNameController,
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
                    if (_formKey.currentState.validate()) {
                      Store store = Store(storeNameController.text, globals.googleSignIn.currentUser.email, 0, null, ownerNameController.text, null, null, null, null, null, null, null, null, null, null);
                      globals.store = store;
                      Navigator.push(context, MaterialPageRoute( builder: (context) =>
                      BusinessDetailsPageTwo()));
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
