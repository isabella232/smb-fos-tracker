import 'package:flutter/material.dart';

class AgentPage extends StatefulWidget {
  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("<Agent name>"),
      ),
    );
  }
}

class MerchantPage extends StatefulWidget {
  @override
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("<Merchant name>"),
      ),
    );
  }
}

