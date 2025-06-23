class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String mainCondition;
  final String iconUrl;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.mainCondition,
    required this.iconUrl,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final DateTime time = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final String iconCode = json['weather'][0]['icon'];
    final String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return HourlyForecast(
      time: time,
      temperature: (json['temp'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'],
      iconUrl: iconUrl,
    );
  }
}