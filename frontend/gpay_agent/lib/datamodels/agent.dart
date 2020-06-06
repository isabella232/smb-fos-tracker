///Model class for storing agent details.
class Agent{
  String AgentEmail;
  String AgentCreationDateTime;   //Look into the datatype
  String AgentFirstName;
  String AgentMidName;
  String AgentLastName;
  String AgentPhone;
  double AgentLatitude;
  double AgentLongitude;

  Agent(
    this.AgentEmail,
    this.AgentCreationDateTime,
    this.AgentFirstName,
    this.AgentMidName,
    this.AgentLastName,
    this.AgentPhone,
    this.AgentLatitude,
    this.AgentLongitude
  );

  @override
  String toString() {
    return 'Agent{AgentEmail: $AgentEmail, AgentCreationDateTime: $AgentCreationDateTime, AgentFirstName: $AgentFirstName, AgentMidName: $AgentMidName, AgentLastName: $AgentLastName, AgentPhone: $AgentPhone, AgentLatitude: $AgentLatitude, AgentLongitude: $AgentLongitude}';
  }
}