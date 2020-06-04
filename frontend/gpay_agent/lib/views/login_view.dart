import 'package:agent_app/datamodels/agent.dart';
import 'package:agent_app/views/welcome_agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget{
  GoogleSignIn _googleSignIn;
  Agent _agent;
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>{
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Agent _agent;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Sign In",
        home: Scaffold(
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Image.asset(
                    "images/GPay_logo.png",
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    "Welcome to Google Pay Agent",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 9),
                    child: Text(
                        "Together let's make money simple",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15
                        )
                    ),
                  ),
                  Image.asset(
                    "images/handshake.gif",
                    width: 350,
                    height: 350,
                  ),
                  OutlineButton(
                    child: Image.asset(
                      "images/sign_in_with_google.png",
                    ),
                    onPressed: _login,
                  )
                ]
            ),
          ),
        )
    );
  }

  _login() async {
    try {
      await _googleSignIn.signIn();
      _agent = new Agent(12, "Pragya", "", "Sethi", 9888899779, 007);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WelcomeAgent(googleSignIn: _googleSignIn, agent: _agent),
          )
      );
    }
    catch (err) {
      print(err);
    }
  }

}