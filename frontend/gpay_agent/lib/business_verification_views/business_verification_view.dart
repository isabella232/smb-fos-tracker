import 'package:flutter/material.dart';
import 'package:agent_app/business_verification_views/business_verification_menu_items.dart';
import 'package:agent_app/business_verification_views/business_verification_success_view.dart';
import 'package:agent_app/business_verification_views/business_verification_failure_view.dart';

/// Displays Verification home page for a Merchant that FOS Agent verifies.
///
/// FOS Agent Verifies the Merchant by checking whether Merchant details like address,
/// phone are correct or not.
class VerificationHomeView extends StatefulWidget {
  _VerificationHomeViewState createState() => _VerificationHomeViewState();
}

class _VerificationHomeViewState extends State<VerificationHomeView> {
  /// Boolean variable[isStorePresent] stores whether store is present in mentioned location or not.
  bool isStorePresent = false;

  /// Boolean variable[isBusinessPresent] stores whether mentioned business is working or not.
  bool isBusinessPresent = false;

  /// Menu actions.
  ///
  /// Shows cancel verification dialog when 'Discard Verification' menu choice is selected.
  void choiceAction(String choice) {
    if (choice == VerificationMenuItems.Cancel) {
      print('Discard Verification');
      //When ever user clicks on discard verification it opens up verification failed
      //TODO: Need to return to home page after cancelling verification
      _showCancelVerificationDialog();
    }
  }

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
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return VerificationMenuItems.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
              height: 50.0,
              child: const Center(
                child: Text(
                  'Verification details',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              child: Row(children: <Widget>[
                Text(
                  'Does store exist ?',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Switch(
                  value: isStorePresent,
                  onChanged: (value) {
                    setState(() {
                      isStorePresent = value;
                      print(isStorePresent);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                ),
              ]),
            ),
            Container(
              height: 50.0,
              child: Center(
                child: Row(children: <Widget>[
                  Text(
                    'Does business exist ?',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Switch(
                    value: isBusinessPresent,
                    onChanged: (value) {
                      setState(() {
                        isBusinessPresent = value;
                        print(isBusinessPresent);
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showVerifyMerchantDialog();
        },
        tooltip: 'Verify',
        shape: RoundedRectangleBorder(),
        elevation: 0.0,
        label: Text(
          'Verify',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  /// Verifies Merchant.
  ///
  /// If [isBusinessPresent] and [isStorePresent] are true then displays [VerificationSuccessView]
  /// else displays [VerificationFailureView].
  void _verifyMerchant() {
    if (isBusinessPresent & isStorePresent) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => VerificationSuccessView()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => VerificationFailureView()));
    }
  }

  /// Displays dialog box confirms whether FOS Agent want to verify or not.
  ///
  /// Dialog box contains CANCEL and VERIFY buttons.
  /// If CANCEL is selected Agent remains on same page
  /// If VERIFY is selected then Merchant details are verified.
  Future<void> _showVerifyMerchantDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Verify the merchant'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('VERIFY'),
              onPressed: () {
                _verifyMerchant();
              },
            ),
          ],
        );
      },
    );
  }

  /// Displays dialog box confirms whether FOS Agent want to delete verification or not.
  ///
  /// Dialog box contains CANCEL and DELETE buttons.
  /// If CANCEL is selected Agent remains on same page
  /// If DELETE is selected then it deletes the verification.
  Future<void> _showCancelVerificationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Delete the verification'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('DELETE'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificationFailureView()));
              },
            ),
          ],
        );
      },
    );
  }
}
