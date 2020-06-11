library gpay_merchant.globals;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'store.dart';

GoogleSignIn googleSignIn;
Store store;

showAlertDialog(String title, String alertMessage, BuildContext context) {
  // This is the setup of the button to give user the choice to click on OK after reading the dialog.
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // This is the setup of the alert dialog based on the provided title.
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(
      alertMessage,
      style: GoogleFonts.montserrat(),
    ),
    actions: [
      okButton,
    ],
  );

  // This is where the alert dialog is displayed.
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
