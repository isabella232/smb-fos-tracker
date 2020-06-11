class Coordinates {
  double latitude;
  double longitude;

  Coordinates(
    this.latitude,
    this.longitude,
  );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
