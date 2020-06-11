import 'package:flutter/material.dart';
import 'package:gpay_merchant/sign_in_home_page.dart';

void main() {
  runApp(GPayMerchantApp());
}

class GPayMerchantApp extends StatelessWidget {
  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPay Merchant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInHomePage(),
    );
  }
}
