import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../models/hourly_forecast.dart';
import '../models/daily_forecast.dart';

class WeatherService {
  final String _apiKey = 'f4d3b8cd859750648938cf4fe247965e';
  final String _currentWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5/weather'; 
  final String _oneCallBaseUrl = 'https://api.openweathermap.org/data/3.0/onecall'; 

  Future<Weather> getWeather(String cityName) async {
    final uri = Uri.parse(
      '$_currentWeatherBaseUrl?q=$cityName&appid=$_apiKey&units=metric&lang=id'
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final String message = errorJson['message'] ?? 'Unknown error';
      throw Exception('Gagal memuat cuaca untuk kota "$cityName". Status: ${response.statusCode}, Pesan: $message');
    }
  }

  Future<Map<String, dynamic>> getOneCallWeather(double lat, double lon) async {
    final uri = Uri.parse(
      '$_oneCallBaseUrl?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=$_apiKey&units=metric&lang=id'
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      final Weather currentWeather = Weather.fromJson(jsonResponse['current']);
      
      final List<HourlyForecast> hourlyForecast = (jsonResponse['hourly'] as List)
          .map((item) => HourlyForecast.fromJson(item))
          .toList();
      
      final List<DailyForecast> dailyForecast = (jsonResponse['daily'] as List)
          .map((item) => DailyForecast.fromJson(item))
          .toList();

      return {
        'current': currentWeather,
        'hourly': hourlyForecast,
        'daily': dailyForecast,
      };
    } else {
      final Map<String, dynamic> errorJson = jsonDecode(response.body);
      final String message = errorJson['message'] ?? 'Unknown error';
      throw Exception('Gagal memuat data cuaca dari API. Status: ${response.statusCode}, Pesan: $message');
    }
  }
}