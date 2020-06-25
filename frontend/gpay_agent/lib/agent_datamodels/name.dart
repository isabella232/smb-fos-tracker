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


/// Model class for storing name of user
class Name {
  String firstName;
  String midName;
  String lastName;

  Name(String first, String mid, String last){
    this.firstName = first;
    this.midName = mid;
    this.lastName = last;
  }

  /// Creates new Name object from json string.
  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      json['firstName'] as String,
      json['middleName'] as String,
      json['lastName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'midName': midName,
        'lastName': lastName,
      };

  String getName(){
    return firstName+" "+midName + " "+ lastName;
  }
}
