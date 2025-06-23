class DailyForecast {
  final DateTime date;
  final double? minTemperature;
  final double? maxTemperature;
  final String mainCondition;
  final String iconUrl;

  DailyForecast({
    required this.date,
    this.minTemperature,
    this.maxTemperature,
    required this.mainCondition,
    required this.iconUrl,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final String iconCode = json['weather'][0]['icon'];
    final String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return DailyForecast(
      date: date,
      minTemperature: (json['temp']['min'] as num?)?.toDouble(),
      maxTemperature: (json['temp']['max'] as num?)?.toDouble(),
      mainCondition: json['weather'][0]['main'],
      iconUrl: iconUrl,
    );
  }
}