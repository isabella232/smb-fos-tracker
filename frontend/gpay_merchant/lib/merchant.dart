import 'package:gpay_merchant/coordinates.dart';

class Merchant {
  String name;
  String email;
  Coordinates coordinates;
  String phone;

  Merchant(this.name, this.email, this.coordinates, this.phone);
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'coordinates': coordinates,
        'phone': phone
      };

}