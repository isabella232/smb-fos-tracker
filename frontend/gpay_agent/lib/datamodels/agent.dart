import 'package:google_sign_in/google_sign_in.dart';

class Agent{
  int AgentID;
  String AgentFirstName;
  String AgentMidName;
  String AgentLastName;
  int AgentPhone;
  int AgentDeviceID;
  Agent(
    this.AgentID,
    this.AgentFirstName,
    this.AgentMidName,
    this.AgentLastName,
    this.AgentPhone,
    this.AgentDeviceID,
  );
}