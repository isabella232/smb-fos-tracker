class Name {
  String firstName;
  String middleName;
  String lastName;

  Name(this.firstName, this.middleName, this.lastName);

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
      };
}
