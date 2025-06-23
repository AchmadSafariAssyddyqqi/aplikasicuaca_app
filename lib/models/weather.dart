class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String mainCondition;
  final String description;
  final String iconUrl;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.mainCondition,
    required this.description,
    required this.iconUrl,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final String iconCode = json['weather'][0]['icon'];
    final String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return Weather(
      cityName: json['name'] ?? 'Unknown Location',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      iconUrl: iconUrl,
      humidity: (json['main']['humidity'] as int),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}