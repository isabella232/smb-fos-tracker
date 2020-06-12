class Address {
  String street;
  String area;
  String city;
  String state;
  String pincode;
  String country;

  Address(this.street, this.area, this.city, this.state, this.pincode,
      this.country);

  Map<String, dynamic> toJson() => {
        'street': street,
        'area': area,
        'city': city,
        'state': state,
        'pincode': pincode,
        'country': country
      };
}
