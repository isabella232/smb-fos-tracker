import 'package:agent_app/agent_datamodels/agent.dart';
import 'package:agent_app/agent_datamodels/text_widget.dart';
import 'package:agent_app/agent_views/fetch_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Builds the UI elements for Welcome Agent user interface and
/// defines function for fetching number of store verified by agent.
class WelcomeAgent extends StatelessWidget{
  WelcomeAgent({this.googleSignIn, this.agent});
  final GoogleSignIn googleSignIn;
  final Agent agent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WelcomeAgent',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          actions: <Widget>[
            RaisedButton(
              child: Text("logout"),
              onPressed: (){
                googleSignIn.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/agent_beginning_images/walking_cloud.gif",
                width: 300,
                height: 300,
              ),
              TextWidget(name: "Welcome Agent", color: Colors.black),
              TextWidget(name: googleSignIn.currentUser.displayName, color: Colors.blue,),
              TextWidget(name: (agent.AgentPhone).toString(), color: Colors.blue,),
              TextWidget(name: "Merchants Verified", color: Colors.black,),
              TextWidget(name: getNumberOfMerchantsVerified().toString(),color: Colors.blue,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FetchStore()
                      ),
                    );
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Verify a Store",
                    ),
                  ),
                ),
              ),
              Image.asset(
                "assets/agent_beginning_images/GPay_logo_rectangle.png",
                width: 300,
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Fetches the number of merchants verified by the agent signed in [agent]
  /// using google spanner APIs.
  int getNumberOfMerchantsVerified(){
    //Makes a call to server sending AgentID. Server sends back the number of merchants verified by this agent
    return 20;
  }
}
