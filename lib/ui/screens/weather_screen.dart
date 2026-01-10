import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/ui/widgets/error_view.dart';
import 'package:weather_app/ui/widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WeatherProvider>().loadWeather());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    final condition = (provider.weather?.weather ?? []).firstOrNull?.main ?? '';
    final backgroundGradient = _getBackgroundGradient(condition);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "Weather App",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _buildBody(provider),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(WeatherProvider provider) {
    if (provider.isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Fetching weather...",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      );
    }

    if (provider.error != null) {
      return ErrorView(
        message: provider.error!,
        textStyle: const TextStyle(color: Colors.white),
        onRetry: () => provider.loadWeather(),
      );
    }

    if (provider.weather == null) {
      return const Text(
        "No weather data available",
        style: TextStyle(color: Colors.white70, fontSize: 16),
      );
    }

    return WeatherCard(
      weather: provider.weather!,
      borderRadius: 20,
      shadowColor: Colors.black45,
      elevation: 8,
      padding: const EdgeInsets.all(24),
    );
  }

  List<Color> _getBackgroundGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return [Colors.blue.shade300, Colors.blue.shade600];
      case 'clouds':
        return [Colors.grey.shade400, Colors.grey.shade800];
      case 'rain':
        return [Colors.blueGrey.shade600, Colors.blueGrey.shade900];
      case 'snow':
        return [Colors.blue.shade100, Colors.blue.shade300];
      case 'thunderstorm':
        return [Colors.deepPurple.shade700, Colors.deepPurple.shade900];
      default:
        return [Colors.blueGrey.shade700, Colors.blueGrey.shade500];
    }
  }
}
