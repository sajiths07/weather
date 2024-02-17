class LocationConfiguration {
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;
  final String timeZone;

  LocationConfiguration({
    required this.cityName,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.timeZone,
  });

  factory LocationConfiguration.fromJson(Map<String, dynamic> json) {
    return LocationConfiguration(
      cityName: json['MALAPURAM'],
      country: json['INDIA'],
      latitude: json['11.067755371674343'],
      longitude: json['76.06289742088295'],
      timeZone: json['India/Delhi'],
    );

  }
}
