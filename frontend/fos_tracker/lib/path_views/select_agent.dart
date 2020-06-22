import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fos_tracker/data_models/store_in_agent_path.dart';
import 'package:fos_tracker/path_views/agent_path.dart';
import 'package:fos_tracker/store.dart';
import 'package:http/http.dart' as http;


class SelectAgent extends StatefulWidget {
  @override
  SelectAgentState createState() => SelectAgentState();
}

class SelectAgentState extends State<SelectAgent> {
  bool _loading = false;
  String agentEmail;
  String errorMessage = "";
  List<StoreForAgentPath> storesInPath;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _loading = false;
    errorMessage = "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Text(
              "Enter the email of agent"
          ),
        Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      else{
                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                        if (!emailValid){
                          return 'Please enter a valid email';
                        }
                        else{
                          agentEmail = value;
                        }
                      }
                      return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        setState(() {
                          _loading = true;
                        });
                        getStoreVerifiedByAgent();


                      }
                    },
                    child: Text('Submit'),
                  ),
                ])
        ),
//          Text(errorMessage, style: TextStyle(color: Colors.red),),
          Container(
            child: _loading? new CircularProgressIndicator():null,
          )
        ],
      ),
    );
  }

  Future<void> getStoreVerifiedByAgent() async{
    String message;
    storesInPath = new List();
    final http.Response response = await http.post(
      'https://fos-tracker-278709.an.r.appspot.com/agent/stores/status/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "agentEmail": agentEmail,
      }),
    );

    print(agentEmail);
    print(response);
    LineSplitter lineSplitter = new LineSplitter();
    List<String> storesList = lineSplitter.convert(response.body);
    print(storesList);

    if(response.statusCode == 200){
      int i = 0;
      List<String> A = ["2020-06-18 20:02:36.217", "2020-06-18 19:39:09.634633", "2020-06-18 21:24:00.196837", "2020-06-18 20:02:53.57481"];
      LineSplitter lineSplitter = new LineSplitter();
      List<String> storesList = lineSplitter.convert(response.body);
      for (var storeJson in storesList){
        if (storeJson == "Successful"){
          continue;
        }
        if (i > 3){
          break;
        }
        Store store = Store.fromJson(jsonDecode(storeJson));
        StoreForAgentPath storeForAgentPath = new StoreForAgentPath(storePhone: store.storePhone, coordinates: store.coordinates, status: store.status, verificationTime: A[i]);
        print(storeForAgentPath.storePhone);
        i ++;
        storesInPath.add(storeForAgentPath);
        print(storesInPath);
      }
      print("Printing stores in path before sorting!!");
      print(storesInPath);

      // Sorting on the basis of time of verification
      storesInPath.sort((StoreForAgentPath store1, StoreForAgentPath store2) {
        DateTime store1Date = DateTime.parse(store1.verificationTime);
        DateTime store2Date = DateTime.parse(store2.verificationTime);
        return store1Date.compareTo(store2Date);
      });

      print("Printing stores in path after sorting!!");
      setState(() {
        errorMessage = "";
        _loading = false;
      });
      print(storesInPath);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentPathPage(agentEmail: agentEmail, storesInPath: storesInPath,),
          ));
    }
    else{
      print("unsuccessful request");
      setState(() {
        errorMessage = message;
        _loading = false;
      });
    }
  }
}