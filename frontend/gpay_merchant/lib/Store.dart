import 'package:geocoder/geocoder.dart';

class Store {
  String StoreName;
  String MerchantEmail;
  int StorePhoneNumber;
  Coordinates StoreCoordinates;
  String MerchantFirstName;
  String MerchantLastName;
  String MerchantMiddleName;
  String MerchantName;
  String StoreStreet;
  String StorePincode;
  String StoreArea;
  String StoreCity;
  String StoreState;
  String StoreCountry;
  DateTime StoreCreationDateTime;

  Store(this.StoreName,
      this.MerchantEmail,
      this.StorePhoneNumber,
      this.StoreCoordinates,
      this.MerchantName,
      this.MerchantFirstName,
      this.MerchantLastName,
      this.MerchantMiddleName,
      this.StoreStreet,
      this.StorePincode,
      this.StoreArea,
      this.StoreCity,
      this.StoreState,
      this.StoreCountry,
      this.StoreCreationDateTime);

}