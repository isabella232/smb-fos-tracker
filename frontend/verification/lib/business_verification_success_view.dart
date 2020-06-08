import 'package:flutter/material.dart';

/// Displays Verification success page.
class VerificationSuccessView extends StatefulWidget {
  _VerificationSuccessViewState createState() =>
      _VerificationSuccessViewState();
}

class _VerificationSuccessViewState extends State<VerificationSuccessView> {
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
                  'Verification Successful!',
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
