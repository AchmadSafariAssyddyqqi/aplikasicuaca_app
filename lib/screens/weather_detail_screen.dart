import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherDetailScreen extends StatelessWidget {
  final Weather weather;
  const WeatherDetailScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: const Text(
          'Detail Cuaca',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.blue,
              Colors.blueAccent,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  color: Colors.blue[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          weather.cityName,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                              shadows: const [
                                Shadow(blurRadius: 2.0, color: Colors.black12, offset: Offset(1.0, 1.0)),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        Image.network(
                          weather.iconUrl,
                          scale: 0.5,
                        ),
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: TextStyle(
                              fontSize: 84,
                              fontWeight: FontWeight.w200,
                              color: Colors.blue[800],
                              shadows: const [
                                Shadow(blurRadius: 3.0, color: Colors.black12, offset: Offset(1.5, 1.5)),
                              ]),
                        ),
                        Text(
                          weather.mainCondition,
                          style: TextStyle(
                              fontSize: 28,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue[800],
                              shadows: const [
                                Shadow(blurRadius: 2.0, color: Colors.black12, offset: Offset(1.0, 1.0)),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildDetailRow('Terasa Seperti', '${weather.feelsLike.toStringAsFixed(1)}°C'),
                _buildDetailRow('Kelembapan', '${weather.humidity}%'),
                _buildDetailRow('Kecepatan Angin', '${weather.windSpeed.toStringAsFixed(1)} m/s'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}