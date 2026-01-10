import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/location_helper.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/services/weather_api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApiService _service = WeatherApiService();

  WeatherModel? weather;
  bool isLoading = false;
  String? error;

  Future<void> loadWeather() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final position = await LocationHelper.getCurrentLocation();
      weather = await _service.fetchWeather(position);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
