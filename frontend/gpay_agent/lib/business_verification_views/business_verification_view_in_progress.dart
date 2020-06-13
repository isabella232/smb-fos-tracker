import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'globals.dart' as globals;
import 'package:agent_app/business_verification_views/business_verification_menu_items.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum iconType{
  face,
  store,
  phone
}

enum verificationType{
  finish,
  revisit,
  store_does_not_exist,
  cancel
}

enum selectCategory{
  merchant_details
}

enum headerName{
  merchant_details,
  business_details,
  business_phone
}

class _MyHomePageState extends State<MyHomePage> {

  bool isSelected = false;
  bool isNameCorrect = false;
  bool isAddressCorrect = false;
  bool isPhoneCorrect = false;
  double headerHeight = 50;
  double headerTextSize = 14;
  double buttonHeight = 50;
  double buttonTextSize = 14;
  double itemHeight = 100;
  double itemTextSize = 12;

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
                if (index > 9) return null;
                switch (index) {
                  case 0:
                    return _buildHeaderItem(headerHeight, headerTextSize, iconType.face, headerName.merchant_details);
                  case 1:
                    return _buildListItem(itemHeight, itemTextSize, headerName.merchant_details);
                  case 2:
                    return _buildHeaderItem(headerHeight, headerTextSize, iconType.store, headerName.business_details);
                  case 3:
                    return _buildListItem(itemHeight, itemTextSize, headerName.business_details);
                  case 4:
                    return _buildHeaderItem(headerHeight, headerTextSize, iconType.phone, headerName.business_phone);
                  case 5:
                    return _buildListItem(itemHeight, itemTextSize, headerName.business_phone);
                  case 6:
                    return _buildButtonItem(buttonHeight, buttonTextSize, verificationType.finish);
                  case 7:
                    return _buildButtonItem(buttonHeight, buttonTextSize, verificationType.revisit);
                  case 8:
                    return _buildButtonItem(buttonHeight, buttonTextSize, verificationType.store_does_not_exist);
                  case 9:
                    return _buildButtonItem(buttonHeight, buttonTextSize, verificationType.cancel);
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
          'Medidoddi Vahini',
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

  Widget _buildHeaderItem(double height, double textSize, iconType icon, headerName name){
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: height,
        child: Row(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.contain, // otherwise the logo will be tiny
              child: _selectIcon(icon),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  _getHeaderText(name),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: textSize,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectIcon(iconType icon){
    switch(icon){
      case iconType.face:
        return Icon(
          Icons.face,
        );
      case iconType.phone:
        return Icon(
          Icons.phone,
        );
      case iconType.store:
        return Icon(
          Icons.store,
        );
    }
  }

  Widget _buildButtonItem(double height, double textSize,verificationType type) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      child: Container(
        height: height,
        child: OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
          highlightedBorderColor: Colors.black,
          onPressed: () { },
          child: Text(
            _getVerificationTypeText(type),
            style: TextStyle(
              color: Colors.blue,
              fontSize: textSize,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  String _getVerificationTypeText(verificationType type){
    switch(type){
      case verificationType.finish:
        return 'Finish Verification';
      case verificationType.revisit:
        return 'Needs another visit';
      case verificationType.store_does_not_exist:
        return 'Store does not exist';
      case verificationType.cancel:
        return 'Cancel';
    }
  }

  String _getHeaderText(headerName name){
    switch(name){
      case headerName.merchant_details:
        return 'MERCHANT DETAILS';
      case headerName.business_details:
        return 'BUSINESS DETAILS';
      case headerName.business_phone:
        return 'BUSINESS PHONE';
    }
  }

  Widget _buildListItem(double itemHeight, double textSize, headerName name) {
    return Padding(
        padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
        child: Container(
          height: itemHeight,
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
                                _getFieldName(name),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            _getFieldValue(name),
                          )
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 2,
                  child: _buildIcons(name)
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        )
    );
  }

  String _getFieldName(headerName name){
    switch(name){
      case headerName.merchant_details:
        return 'Merchant Name';
      case headerName.business_details:
        return 'Address';
      case headerName.business_phone:
        return 'Phone Number';
    }
  }

  String _getFieldValue(headerName name){
    switch(name){
      case headerName.merchant_details:
        return globals.merchantName;
      case headerName.business_details:
        return globals.address;
      case headerName.business_phone:
        return globals.phone;
    }
  }

  bool _getVariableValue(headerName name){
    switch(name){
      case headerName.merchant_details:
        return isNameCorrect;
      case headerName.business_details:
        return isAddressCorrect;
      case headerName.business_phone:
        return isPhoneCorrect;
    }
  }

  void _setVariableValue(headerName name, bool value){
    switch(name){
      case headerName.merchant_details:
        isNameCorrect = value;
        break;
      case headerName.business_details:
        isAddressCorrect = value;
        break;
      case headerName.business_phone:
        isPhoneCorrect = value;
        break;
    }
  }

  Widget _buildIcons(headerName name){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: InkWell(
            splashColor: Colors.white,
            onTap: (){
              _setVariableValue(name,false);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                color: !_getVariableValue(name) ? Colors.red[100] : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: !_getVariableValue(name) ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child:InkWell(
            splashColor: Colors.white,
            onTap: (){
              _setVariableValue(name,true);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                color: _getVariableValue(name) ? Colors.green[100] : Colors.white,
                shape: BoxShape.circle,
              ),
              child:Icon(
                Icons.done,
                color: _getVariableValue(name) ? Colors.green : Colors.blue,
              ),
            ),
          ),
        )
      ],
    );
  }
}
