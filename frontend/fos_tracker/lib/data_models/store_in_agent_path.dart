import 'package:fos_tracker/coordinates.dart';

/*
  This class is a model for a store.
 */
class StoreForAgentPath {
  final String storePhone;
  final Coordinates coordinates;
  final String status;
  final String verificationTime;

  StoreForAgentPath({this.storePhone, this.coordinates, this.status, this.verificationTime});

  factory StoreForAgentPath.fromJson(Map<String, dynamic> json) {
    return new StoreForAgentPath(
        storePhone: json['phone'],
        coordinates: Coordinates.fromJson(json['coordinates']),
        status: json['verificationStatus'],
        verificationTime: json['verificationTime'],
    );
  }
}
