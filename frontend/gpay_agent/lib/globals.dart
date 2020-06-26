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

/// Global library for storing details that remain common through all views
/// of application. [googleSignIn] is google account details of agent signed
/// in. [agent] is the agent registered with [googleSignIn.email]
/// [newVerification] is verification object that store present verification that is sent

library gpay_agent.globals;

import 'package:agent_app/agent_datamodels/agent.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:agent_app/agent_datamodels/store.dart';
import 'package:agent_app/agent_datamodels/store_status.dart';
import 'business_verification_data/verification.dart';


GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
Agent agent;
int merchantsVerifiedbyAgent = 0;
bool isStorePresent;
bool isStoreVerified;
Store store;
StoreStatus storeStatus;
enum verificationStatus{
  success,
  failure,
  needs_revisit,
  not_verified
}

Verification newVerification;
