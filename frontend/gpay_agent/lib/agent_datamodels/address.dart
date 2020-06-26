/*
Copyright 2020 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/// Stores Store Address.
class Address{
  String street;
  String area;
  String city;
  String state;
  String pincode;
  String country;

  Address(this.street, this.area, this.city, this.state, this.pincode,
      this.country);

  /// Creates new Address object from json string.
  factory Address.fromJson(Map<String, dynamic> json){
    return new Address(
        json['street'] as String,
        json['area'] as String,
        json['city'] as String,
        json['state'] as String,
        json['pincode'] as String,
        json['country'] as String
    );
  }

  String getAddress(){
    return street + ", " + area + ", " + city + ", " + state + ", " + pincode + ", " + country;
  }

}