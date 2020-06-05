import 'coordinates.dart';

class Store {
  String storeName;
  String merchantEmail;
  int storePhoneNumber;
  Coordinates storeCoordinates;
  String merchantFirstName;
  String merchantLastName;
  String merchantMiddleName;
  String merchantName;
  String storeStreet;
  String storePincode;
  String storeArea;
  String storeCity;
  String storeState;
  String storeCountry;
  DateTime storeCreationDateTime;

  Store(this.storeName,
      this.merchantEmail,
      this.storePhoneNumber,
      this.storeCoordinates,
      this.merchantName,
      this.merchantFirstName,
      this.merchantLastName,
      this.merchantMiddleName,
      this.storeStreet,
      this.storePincode,
      this.storeArea,
      this.storeCity,
      this.storeState,
      this.storeCountry,
      this.storeCreationDateTime);

}