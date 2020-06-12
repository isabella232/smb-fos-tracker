import 'package:flutter/material.dart';

///Displays Verification failure page.
class VerificationFailureView extends StatefulWidget {
  _VerificationFailureViewState createState() =>
      _VerificationFailureViewState();
}

class _VerificationFailureViewState extends State<VerificationFailureView> {
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
            Image.asset('assets/verification_images/thumbs_down_failure.gif'),
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
