import 'package:fos_tracker/coordinates.dart';

class Store {
  String storePhone;
  Coordinates coordinates;
  String status;

  Store({this.storePhone, this.coordinates, this.status});

  factory Store.fromJson(Map<String, dynamic> json) {
    return new Store(
        storePhone: json['storePhone'],
        coordinates: Coordinates.fromJson(json['storeCoordinates']),
        status: json['verificationStatus']);
  }
}
