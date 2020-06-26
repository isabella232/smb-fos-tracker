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

import 'package:fos_tracker/coordinates.dart';

/*
  This class is a model for a store.
 */
class StoreForAgentPath {
  final String storePhone;
  final Coordinates coordinates;
  final String status;
  final String verificationDateTime;

  StoreForAgentPath(
      {this.storePhone,
      this.coordinates,
      this.status,
      this.verificationDateTime});

  factory StoreForAgentPath.fromJson(Map<String, dynamic> json) {
    return new StoreForAgentPath(
      storePhone: json['phone'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      status: json['verificationStatus'],
      verificationDateTime: json['verificationDateTime'],
    );
  }
}
