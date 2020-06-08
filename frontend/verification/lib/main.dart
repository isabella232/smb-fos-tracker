import 'package:flutter/material.dart';
import 'package:verification/business_registration_details_view.dart';
import 'package:google_fonts/google_fonts.dart';

/// The function that is called when main.dart is run.
void main() => runApp(VerificationStartView());

/// This widget is the root of verification application.
///
/// The first screen we see contains Merchant details and then goes for the
/// Merchant Verification screen followed by Success or Failure screen
class VerificationStartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verification',
      //sets the font theme to Montserrat over the verification application
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MerchantHomeView(),
    );
  }
}
