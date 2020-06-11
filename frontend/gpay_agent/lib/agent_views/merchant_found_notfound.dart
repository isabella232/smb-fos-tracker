import 'package:agent_app/agent_datamodels/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:agent_app/business_verification_views/business_registration_details_view.dart';

/// Builds UI if store searched for is not found in database.
class MerchantNotFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextWidget(name: "Merchant Not Found", color: Colors.black),
            Image.asset(
              "assets/agent_beginning_images/not_found.gif",
              width: 350,
              height: 350,
            ),
            ButtonTheme(
              minWidth: 200,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                color: Colors.blue,
                child: new Text("Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Builds UI if store searched for is found in database.
class MerchantFound extends StatelessWidget{
  MerchantFound({this.name});
  String name;
  int milliseconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextWidget(name: "Merchant Found", color: Colors.black),
            TextWidget(name: name, color: Colors.blue),
            TextWidget(name: "9999999999", color: Colors.blue),
            Image.asset(
              "assets/agent_beginning_images/tick.gif",
              width: 350,
              height: 350,
            ),
            ButtonTheme(
              minWidth: 200,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MerchantHomeView(),
                    ),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                child: new Text("Start Verification"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}