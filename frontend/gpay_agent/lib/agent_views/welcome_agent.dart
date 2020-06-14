import 'package:agent_app/agent_views/fetch_store.dart';
import 'package:agent_app/custom_widgets//app_bar.dart';
import 'package:agent_app/custom_widgets/personal_details_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:agent_app/agent_datamodels/globals.dart' as globals;

class WelcomeAgent extends StatefulWidget{
  _WelcomeAgentState createState() => _WelcomeAgentState();
}

/// Builds the UI elements for Welcome Agent user interface and
/// defines function for fetching number of store verified by agent.
class _WelcomeAgentState extends State<WelcomeAgent>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(globals.agent.getName(), Colors.white),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Image.asset(
              "assets/agent_beginning_images/using_gpay.png",
              height: 200,
            ),
            Center(
              child: Text(
                "AGENT PROFILE",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 20),
            PersonalDetailsTextBox(title: "Name", value: globals.agent.getName(), icon: Icon(Icons.face),),
            SizedBox(height: 10,),
            PersonalDetailsTextBox(title: "Phone Number", value: globals.agent.AgentPhone, icon: Icon(Icons.phone),),
            SizedBox(height: 10,),
            PersonalDetailsTextBox(title: "Joining Date", value: globals.agent.AgentCreationDateTime, icon: Icon(Icons.calendar_today),),
            SizedBox(height: 10,),
            PersonalDetailsTextBox(title: "Number of merchants verified", value: (globals.merchantsVerifiedbyAgent).toString(), icon: Icon(Icons.star),),
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
//              width: 100,
              height: 40,
            ),
          ]
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
