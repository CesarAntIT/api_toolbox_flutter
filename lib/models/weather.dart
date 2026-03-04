class Weather {
  final int humidity;
  final double temperature;
  final double windSpeed;
  final int windDirection;
  final int weatherCode;

  Weather({
    required this.humidity,
    required this.temperature,
    required this.weatherCode,
    required this.windDirection,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return (Weather(
      humidity: json['current']['relative_humidity_2m'] ?? 0,
      temperature: (json['current']['temperature_2m'] as num).toDouble(),
      windSpeed: (json['current']['wind_speed_10m'] as num).toDouble(),
      windDirection: json['current']['wind_direction_10m'] ?? 0,
      weatherCode: json['current']['weather_code'] ?? 0,
    ));
  }
}
