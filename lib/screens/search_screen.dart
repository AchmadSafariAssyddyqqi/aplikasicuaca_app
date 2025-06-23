import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import 'weather_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Weather? _searchedWeather;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _searchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _searchedWeather = null;
    });

    try {
      final weather = await _weatherService.getWeather(_cityController.text.trim());
      setState(() {
        _searchedWeather = weather;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not find weather for this city. Please check the city name.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Kota',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _searchWeather,
                ),
              ),
              onSubmitted: (value) => _searchWeather(),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : _errorMessage != null
                    ? Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                        textAlign: TextAlign.center,
                      )
                    : _searchedWeather != null
                        ? _buildWeatherResult(_searchedWeather!)
                        : const Text(
                            'Cari kota untuk melihat cuacanya.',
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherResult(Weather weather) {
    return Card(
      elevation: 8,
      color: Colors.blue[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
            const SizedBox(height: 10),
            Image.network(weather.iconUrl, width: 100, height: 100),
            const SizedBox(height: 10),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
            Text(
              weather.mainCondition,
              style: TextStyle(fontSize: 22, color: Colors.blue[900]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherDetailScreen(weather: weather),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[700],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Lihat Detail', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}