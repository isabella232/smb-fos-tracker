import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'BusinessDetailsPageThree.dart';
import 'Store.dart';
import 'maptry.dart';
class BusinessDetailsPageTwo extends StatefulWidget {
  BusinessDetailsPageTwo({Key key, this.googleSignIn, this.store}) : super(key: key);
  GoogleSignIn googleSignIn;
  Store store;
  @override
  _BusinessDetailsPageTwoState createState() => _BusinessDetailsPageTwoState();
}

class _BusinessDetailsPageTwoState extends State<BusinessDetailsPageTwo> {
  TextEditingController pin = TextEditingController();
    TextEditingController street = TextEditingController();
    TextEditingController area = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController county = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool validate = false;
    bool mapvalid = true;

  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle styleBold = GoogleFonts.montserrat(fontWeight: FontWeight.w500);
    TextStyle style = GoogleFonts.montserrat();
    

    bool buttonpressed = false;
    bool sName = false;
    bool bName = false;
    String sNameValid(String val) {
      if (validate == false && (val == null || val.length == 0)) {
        return "Registered business name required";
      }
      return null;
    }
    showAlertDialog(String title, String alertMessage, BuildContext context) {

      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(alertMessage, style: GoogleFonts.montserrat(),),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
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
      body: Form(key: _formKey,
    child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.01, width * 0.05, height * 0.05),
          child: ListView(
            children: <Widget>[
              Text("Business location (2/3)",
                style: styleBold.copyWith(
//                    fontSize: 12,
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              Text("put location and confirm on map",
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
              TextFormField(
                controller: pin,
                style: style,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  try {
                    var pincode = int.parse(value);
                    if (pincode < 100000 || pincode > 999999) {
                       return "Invalid Pincode";
                    }
                  }
                  on FormatException {
                    return "Invalid Pincode";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'PIN code',
                  hintStyle: style.copyWith(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: street,
                style: style,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Shop number and street name',
                  hintStyle: style.copyWith(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: area,
                style: style,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Area/locality/village',
                  hintStyle: style,
                ),
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: city,
                style: style,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'City',
                  hintStyle: style,
                ),
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              TextFormField(
                controller: county,
                style: style,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'State/County',
                  hintStyle: style,
                ),
              ),
              SizedBox(
                height: (height * 0.015),
              ),
              FloatingActionButton.extended(
                icon: validate? Icon(Icons.check) : Icon(Icons.map),
                label: Text("Confirm on map"),
                backgroundColor: mapvalid ? Colors.blue : Colors.red,
                onPressed: () async{
                 if  ((city.text == null || city.text.isEmpty) || (street.text == null || street.text.isEmpty))
                   showAlertDialog("Error", "Select city and street", context);

                  else {
                      final query = street.text + ", " + city.text;
                      var addresses;
                      try {
                        addresses = await Geocoder.local.findAddressesFromQuery(query);}
                      catch (err) {
                        showAlertDialog("Error","Error with processing address", context);
                      }
                      var first = addresses.first;
                      print("${first.featureName} : ${first.coordinates}");
                    var result = await Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          MapSample(city: city.text, street: street.text, latitude: first.coordinates.latitude, longitude: first.coordinates.longitude,)));
                    showAlertDialog("Success","Location Selected", context);
                    setState(() {
                      validate = true;
                      mapvalid = true;
                    });
                  }
                },
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      //TODO: create store object and pass it
                      if (_formKey.currentState.validate() && validate)
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              BusinessDetailsPageThree(googleSignIn: widget.googleSignIn, store: widget.store,)));
                              else setState(() {
                                mapvalid = false;
                              });;
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
