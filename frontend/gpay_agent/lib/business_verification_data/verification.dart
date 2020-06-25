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

import 'dart:convert';
import 'package:agent_app/globals.dart' as globals;

import 'package:agent_app/business_verification_data/Coordinates.dart';

class Verification {
  String agentEmail;
  String storePhone;
  Coordinates verificationCoordinates;
  globals.verificationStatus status;

  Verification(
      {this.agentEmail,
        this.storePhone,
        this.verificationCoordinates,
        this.status});

  String convertToJsonString(){
    return jsonEncode( <String ,dynamic>{
      "agentEmail":agentEmail,
      "storePhone":storePhone,
      "verificationCoordinates":{
        "latitude":verificationCoordinates.latitude,
        "longitude":verificationCoordinates.longitude
      },
      "verificationStatus":_getStatus(status)
    });
  }

  String _getStatus(globals.verificationStatus status){
    switch(status){
      case globals.verificationStatus.success:
        return "green";
      case globals.verificationStatus.failure:
        return "red";
      case globals.verificationStatus.needs_revisit:
        return "yellow";
      case globals.verificationStatus.not_verified:
        return "grey";
    }
  }
}