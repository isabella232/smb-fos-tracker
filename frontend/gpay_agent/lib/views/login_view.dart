import 'package:agent_app/datamodels/agent.dart';
import 'package:agent_app/views/welcome_agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

///Creates [LoginViewState] object.
class LoginView extends StatefulWidget{
  @override
  LoginViewState createState() => LoginViewState();
}

///Creates the widgets that are visible at the running state of
///login view interface.
class LoginViewState extends State<LoginView>{
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

  ///Calls signIn function of Google Sign in plugin.
  ///Navigates to [WelcomeAgent] interface if signed in account is authenticated
  ///by firebase authentication otherwise prints error on console and stays
  ///on the [LoginViewState] interface.
  _login() async {
    try {
      await _googleSignIn.signIn();
      _agent = new Agent("pragya@mail.com", "5-6-20 11:00", "Pragya", "", "Sethi", "9888899779", 12.5,34.5);
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