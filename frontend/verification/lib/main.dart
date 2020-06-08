import 'package:flutter/material.dart';
import 'package:verification/business_registration_details_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(VerificationStartView());


class VerificationStartView extends StatelessWidget {
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
      home: MerchantHomeView(),
    );
  }
}
