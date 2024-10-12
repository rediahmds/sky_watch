class OpenWeatherReverseGeocoding {
  String name;
  Map<String, String> localNames;
  double lat;
  double lon;
  String country;

  OpenWeatherReverseGeocoding({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
  });

  // Factory constructor for creating a new instance from a map
  factory OpenWeatherReverseGeocoding.fromJson(Map<String, dynamic> json) {
    // Convert local_names from dynamic type to Map<String, String>
    Map<String, String> localNames =
        Map<String, String>.from(json['local_names'] ?? {});

    return OpenWeatherReverseGeocoding(
      name: json['name'],
      localNames: localNames,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] ?? '', // Add default value in case it's missing
    );
  }
}
