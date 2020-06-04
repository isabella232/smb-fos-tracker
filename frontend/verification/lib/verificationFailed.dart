import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class verificationFailed extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    theme: ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
    );
    return MaterialApp(
      home: VerificationFailed(),
    );
  }
}

class VerificationFailed extends StatefulWidget {
  VerificationFailed({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VerificationFailedState createState() => _VerificationFailedState();
}

class _VerificationFailedState extends State<VerificationFailed> {

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
            Image.asset('assets/thumbs_down_failure.gif'),
            Container(
              height: 50.0,
              child: const Center(
                child: Text(
                  'Verification Failed!',
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
