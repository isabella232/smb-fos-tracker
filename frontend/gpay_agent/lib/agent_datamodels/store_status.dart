import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:agent_app/globals.dart' as globals;

/// StoreStatus model that has the Store fetched from spanner database.
class StoreStatus {
  String status;

  StoreStatus({
    this.status,
  });

  /// Creates new Store object from json string.
  factory StoreStatus.fromJson(Map<String, dynamic> json) {
    return new StoreStatus(status: json['status']);
  }

  /// Fetches store from the spanner database.
  static Future<Null> fetchStoreStatus(String phone) async {
    var response = await http.post(
        "https://fos-tracker-278709.an.r.appspot.com/store/phone/status",
        body: jsonEncode(<String, String>{"storePhone": phone}));
    if (response.statusCode == 200) {
      try {
        LineSplitter lineSplitter = new LineSplitter();
        List<String> lines = lineSplitter.convert(response.body);
        String jsonString = lines[0];
        globals.storeStatus = StoreStatus.fromJson(jsonDecode(jsonString));
        if (globals.storeStatus.status == "green" ||
            globals.storeStatus.status == "red") {
          print('The Store is verified');
          globals.isStoreVerified = true;
        } else {
          globals.isStoreVerified = false;
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Store status is not verified');
    }
  }
}
