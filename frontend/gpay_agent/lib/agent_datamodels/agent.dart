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


import 'coordinates.dart';
import 'name.dart';

///Model class for storing agent details.
class Agent {
  String AgentEmail;
  Name AgentName;
  String AgentPhone;
  String AgentCreationDateTime;
  MapCoordinates AgentCoordinates;

  Agent(
    this.AgentEmail,
    this.AgentName,
    this.AgentPhone,
    this.AgentCreationDateTime,
    this.AgentCoordinates,
  );

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      json['email'] as String,
      Name.fromJson(json['name']),
      json['phone'] as String,
      json['agentCreationDateTime'] as String,
      MapCoordinates.fromJson(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() => {
        'AgentEmail': AgentEmail,
        'AgentName': AgentName.toJson(),
        'AgentPhone': AgentPhone,
        'AgentCreationDateTime': AgentCreationDateTime,
        'Coordinates': AgentCoordinates.toJson(),
      };

  String getName() {
    if ((AgentName.midName).isEmpty) {
      return (AgentName.firstName + " " + AgentName.lastName);
    } else {
      return (AgentName.firstName +
          " " +
          AgentName.midName +
          " " +
          AgentName.lastName);
    }
  }
}