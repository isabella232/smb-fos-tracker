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
