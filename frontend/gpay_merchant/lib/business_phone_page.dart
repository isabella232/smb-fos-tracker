import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'globals.dart' as globals;
import 'registration_success_page.dart';

class BusinessDetailsPageThree extends StatefulWidget {
  @override
  _BusinessDetailsPageThreeState createState() =>
      _BusinessDetailsPageThreeState();
}

/*
 * This class contains the view to accept the business phone number.
 */
class _BusinessDetailsPageThreeState extends State<BusinessDetailsPageThree> {
  TextEditingController phoneController = TextEditingController();
  final formValidationKey = GlobalKey<FormState>();
  bool validate = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle styleBold = GoogleFonts.montserrat(fontWeight: FontWeight.w500);

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
        body: Form(
          key: formValidationKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.05, height * 0.01, width * 0.05, height * 0.05),
              child: ListView(
                children: <Widget>[
                  Text(
                    "Business mobile number (3/3)",
                    style: styleBold.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: (height * 0.03),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'images/flag.png',
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text(
                        "+91",
                        style: GoogleFonts.montserrat(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      SizedBox(
                        width: 0.01,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: phoneController,
                          style: GoogleFonts.montserrat(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Cannot be empty";
                            }
                            try {
                              var result = int.parse(value);
                              if (result < 1000000000 || result > 9999999999) {
                                return "Invalid Number";
                              }
                            } on FormatException {
                              return "Invalid Number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: '10 digit phone number',
                            hintStyle: GoogleFonts.montserrat(),
                          ),
                        ),
                      )
                    ],
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
                        onPressed: () async {
                          // TODO: HTTP POST
                          setState(() {
                            isLoading = true;
                          });
                          if (formValidationKey.currentState.validate()) {
                            globals.store.phone = phoneController.text;
                            String storeJson = jsonEncode(globals.store);
                            http.Response response = await http.post(
                                "http://fos-tracker-278709.an.r.appspot.com/stores/add",
                                body: storeJson);
                            setState(() {
                              isLoading = false;
                            });
                            if (response.statusCode != 200) {
                              globals.showAlertDialog(
                                  "Error", "Could not register store", context);
                            } else {
                              //Since the reference to the latest  pages (business basic details, business location and business phone) are not needed, they are popped.
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FinalPage()));
                            }
                          }
                        },
                        child: Text(
                          "Next",
                          style: GoogleFonts.montserrat(),
                        ),
                      )),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ));
  }
}
