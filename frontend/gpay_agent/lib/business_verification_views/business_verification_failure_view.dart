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
      body: OrientationBuilder(
          builder: (context, orientation){
            if(orientation == Orientation.portrait){
              return _buildFailurePortraitView();
            }
            else{
              return _buildFailureLandScapeView();
            }
          }
      )
    );
  }

  /// Builds failure landscape view.
  ///
  /// Contains gif and message in a row.
  Widget _buildFailureLandScapeView(){
    return  Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/verification_images/thumbs_down_failure.gif'),
            )
        ),
        Expanded(
          flex: 1,
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
    );
  }

  /// Builds failure portrait view.
  ///
  /// Contains gif and message in a column.
  Widget _buildFailurePortraitView(){
    return  Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/verification_images/thumbs_down_failure.gif'),
            )
        ),
        Expanded(
          flex: 1,
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
    );
  }
}
