import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'globals.dart' as globals;
import 'package:agent_app/business_verification_views/business_verification_menu_items.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSilverAppBar(height),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                /// To convert this infinite list to a list with "n" no of items,
                /// uncomment the following line:
                if (index > 10) return null;
                switch (index) {
                  case 0:
                    return _merchantDetailsHeaderItem(height);
                  case 1:
                    return _merchantNameItem(height, width);
                  case 2:
                    return _businessDetailsHeaderItem(height);
                  case 3:
                    return listItem(Colors.brown, "Sliver List item: $index");
                  case 4:
                    return _businessPhoneItem(height);
                  case 5:
                    return listItem(Colors.brown, "Sliver List item: $index");
                  case 7:
                    return _finishVerificationItem(height);
                  case 8:
                    return _needAnotherVisitItem(height);
                  case 9:
                    return _storeDoesNotExistItem(height);
                  case 10:
                    return _cancelItem(height);
                  default:
                    return listItem(Colors.green, "Sliver List item: $index");
                }
              },
            ),
          )
        ],
      ),
    );
  }

  /// SilverAppBar displaying Merchant Name
  /// leading up button
  SliverAppBar _buildSilverAppBar(double height) {
    double expandedHeight = 200;
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text(
            'Medidoddi Vahini'
        ),
        centerTitle: true,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[_buildPopUpMenu()],
    );
  }

  void choiceAction(String choice) {
    if (choice == VerificationMenuItems.Cancel) {
      //When ever user clicks on discard verification it opens up verification failed
      //TODO: Need to return to home page after cancelling verification
      /*runApp(MyApp());
      _showCancelVerificationDialog();*/
    }
  }

  //builds popup menu
  PopupMenuButton _buildPopUpMenu() {
    return PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return VerificationMenuItems.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Widget listItem(Color color, String title) => Container(
    height: 100.0,
    color: color,
    child: Center(
      child: Text(
        "$title",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  Widget _merchantDetailsHeaderItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            FittedBox(
                fit: BoxFit.contain, // otherwise the logo will be tiny
                child: Icon(
                  Icons.face,
                )),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('MERCHANT DETAILS',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _businessDetailsHeaderItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            FittedBox(
                fit: BoxFit.contain, // otherwise the logo will be tiny
                child: Icon(
                  Icons.store,
                )),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('BUSINESS DETAILS',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _businessPhoneItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 70,
        child: Row(
          children: <Widget>[
            FittedBox(
                fit: BoxFit.contain, // otherwise the logo will be tiny
                child: Icon(
                  Icons.phone,
                )),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('BUSINESS PHONE',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _needAnotherVisitItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 50,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
          highlightedBorderColor: Colors.black,
          onPressed: () { },
          child: Text(
            'Needs another visit',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _finishVerificationItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 50,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
          highlightedBorderColor: Colors.black,
          onPressed: () { },
          child: Text(
            'Finish Verification',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _storeDoesNotExistItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 50,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
          highlightedBorderColor: Colors.black,
          splashColor: Colors.blueAccent,
          onPressed: () { },
          child: Text(
            'Store does not exist',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _cancelItem(double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: 50,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
          highlightedBorderColor: Colors.black,
          onPressed: () { },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _merchantNameItem(double height, double width) {
    double itemHeight = height * 0.1;
    return Padding(
        padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
        child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Merchant Name',
                              )
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            globals.merchantName,
                          )
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 1,
                  child: FittedBox(
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.pause,
                        ),
                        shape: CircleBorder(),
                      )
                  )
              ),
              Expanded(
                  flex: 1,
                  child: FittedBox(
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        fillColor: Colors.blue,
                        /*child: Icon(
                          Icons.pause,
                        ),*/
                        shape: CircleBorder(),
                      )
                  )
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        )
    );
  }
}
