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

import 'package:agent_app/list_of_stores_with_directions/coordinate.dart';

/// Stores the store object that is fetched from spanner.
class Store {
  String storePhone;
  Coordinates coordinates;
  String status;
  String storeName;

  Store({this.storePhone, this.coordinates, this.status, this.storeName});

  factory Store.fromJson(Map<String, dynamic> json) {
    return new Store(
        storePhone: json['phone'],
        coordinates: Coordinates.fromJson(json['coordinates']),
        storeName: json['storeName'],
        status: json['verificationStatus']);
  }
}
