import 'package:flutter/material.dart';
import 'package:weather_app/widgets/cloud_painter.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Weather? _weather;
  final WeatherService _weatherService = WeatherService();
  final String _currentCity = 'Pamekasan';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather(_currentCity);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat cuaca: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final double screenWidth = MediaQuery.of(context).size.width;
                final double cloudWidth = 200;
                final double animationValue = _controller.value;
                final double offsetX = -cloudWidth + (screenWidth + cloudWidth * 2) * animationValue;
                return Transform.translate(
                  offset: Offset(offsetX, 0),
                  child: CustomPaint(
                    size: const Size(200, 100),
                    painter: CloudPainter(cloudColor: Colors.white.withOpacity(0.8)),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 120,
            right: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final double screenWidth = MediaQuery.of(context).size.width;
                final double cloudWidth = 250;
                final double animationValue = _controller.value;
                final double offsetX = -cloudWidth + (screenWidth + cloudWidth * 2) * (1.0 - animationValue);
                return Transform.translate(
                  offset: Offset(offsetX, 0),
                  child: CustomPaint(
                    size: const Size(250, 120),
                    painter: CloudPainter(cloudColor: Colors.white.withOpacity(0.7)),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 200,
            left: 50,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final double screenWidth = MediaQuery.of(context).size.width;
                final double cloudWidth = 150;
                final double animationValue = _controller.value;
                final double offsetX = -cloudWidth + (screenWidth + cloudWidth * 1.5) * (animationValue * 0.7);
                return Transform.translate(
                  offset: Offset(offsetX, 0),
                  child: CustomPaint(
                    size: const Size(150, 75),
                    painter: CloudPainter(cloudColor: Colors.white.withOpacity(0.85)),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Center(
              child: _weather == null
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Nama Kota
                        Text(
                          _weather!.cityName,
                          style: const TextStyle(
                              // Ukuran font nama kota diperkecil dari 48 menjadi 38
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: Colors.black38,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${_weather!.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                              // Ukuran font suhu diperkecil dari 96 menjadi 72
                              fontSize: 72,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: Colors.black38,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _weather!.mainCondition,
                          style: TextStyle(
                              // Ukuran font kondisi cuaca diperkecil dari 32 menjadi 24
                              fontSize: 24,
                              color: Colors.white.withOpacity(0.9),
                              shadows: const [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black38,
                                  offset: Offset(1.5, 1.5),
                                ),
                              ]),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}