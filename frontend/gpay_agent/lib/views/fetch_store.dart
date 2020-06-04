import 'package:agent_app/views/merchant_found_notfound.dart';
import 'package:agent_app/views/qr_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class FetchStore extends StatelessWidget{
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String num = "1223";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GetStoreInfo",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Get Store"),
          actions: <Widget>[
            IconButton(
              tooltip: "logout",
              icon: Icon(Icons.face),
              onPressed: null,
            )
          ],
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "images/agent_merchant_handshake.gif",
                  width: 250,
                  height: 250,
                ),
                Text(
                  "Enter Store Phone",
                  style: TextStyle(
                      fontSize: 22
                  ),
                ),
                Container(
                  width: 300,
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number){
                      print(number.phoneNumber);
                      num = (number.phoneNumber).toString();
                    },
                    initialValue: number,
                  ),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      print(num);
                      if (num == "+919999999999"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MerchantFound(name: "Alice Peterson",),
                          ),
                        );
                      }
                      else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MerchantNotFound(),
                          ),
                        );
                      }

                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: new Text("Submit"),
                  ),
                ),
                Text("OR"),
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrScan(),
                      ),
                    );
                  },
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: new Text("Scan QR Code"),
                  ),
                ),
                Image.asset(
                  "images/GPay_logo_rectangle.png",
                  width: 200,
                  height: 100,
                )
              ],
            )
        ),
      ),
    );
  }
}

class Button extends StatelessWidget{
  Button({this.name, this.function});
  final String name;
  final void function;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 50,
      child: RaisedButton(
        onPressed: ()=>function,
        textColor: Colors.white,
        color: Colors.blue,
        child: new Text(name),
      ),
    );
  }
}