import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final double borderRadius;
  final double elevation;
  final Color shadowColor;
  final EdgeInsetsGeometry padding;

  const WeatherCard({
    super.key,
    required this.weather,
    this.borderRadius = 20,
    this.elevation = 6,
    this.shadowColor = Colors.black26,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  offset: const Offset(0, 8),
                  blurRadius: elevation,
                ),
              ],
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weather.name??'',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   "https://openweathermap.org/img/wn/${weather.}@2x.png",
                    //   width: 60,
                    //   height: 60,
                    // ),
                    const SizedBox(width: 16),
                    Text(
                      "${weather.main?.temp?.toStringAsFixed(1)??''}°C",
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  (weather.weather??[]).firstOrNull?.description??'',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoColumn(
                      Icons.water_drop,
                      "${weather.main?.humidity??0}%",
                      "Humidity",
                    ),
                    _infoColumn(Icons.air, "${weather.wind?.speed??0} m/s", "Wind"),
                    _infoColumn(
                      Icons.thermostat,
                      "${weather.main?.feelsLike?.toStringAsFixed(1)}°C",
                      "Feels Like",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white60),
        ),
      ],
    );
  }
}
