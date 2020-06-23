import 'package:flutter/material.dart';

/// Displays Merchant already verified view.
///
/// Whenever Agent tries to select store that is already verified it displays
/// 'Store already verified'.
class MerchantVerifiedView extends StatefulWidget {
  _MerchantVerifiedViewState createState() => _MerchantVerifiedViewState();
}

class _MerchantVerifiedViewState extends State<MerchantVerifiedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottomOpacity: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text(
              'Store already verified.',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Text(
              'Please select another store',
              style: TextStyle(
                fontSize: 17,
              ),
            )
          ],
        )));
  }
}
