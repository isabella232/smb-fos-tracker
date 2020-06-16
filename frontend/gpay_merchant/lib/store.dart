import 'address.dart';
import 'coordinates.dart';
import 'name.dart';

class Store {
  Name ownerName;
  String email;
  Address storeAddress;
  Coordinates coordinates;
  String phone;
  String storeName;

  Store(this.ownerName, this.email, this.storeAddress, this.coordinates,
      this.phone, this.storeName);

  Map<String, dynamic> toJson() => {
        'ownerName': ownerName,
        'email': email,
        'storeAddress': storeAddress,
        'coordinates': coordinates,
        'phone': phone,
        'storeName': storeName
      };
}
