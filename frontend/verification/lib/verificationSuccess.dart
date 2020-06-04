import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class verificationSuccess extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: VerificationSuccess(),
    );
  }
}

class VerificationSuccess extends StatefulWidget {
  VerificationSuccess({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VerificationSuccessState createState() => _VerificationSuccessState();
}

class _VerificationSuccessState extends State<VerificationSuccess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Image.asset('assets/thumbs_up_success.gif'),
            Container(
              height: 50.0,
              child: const Center(
                child: Text(
                  'Verification Success!',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
