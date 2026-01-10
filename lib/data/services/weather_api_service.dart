import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/errors/app_exception.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherApiService {
  Future<WeatherModel> fetchWeather(Position position) async {
    final url =
        '${ApiConstants.baseUrl}?lat=${position.latitude}&lon=${position.longitude}&appid=${ApiConstants.apiKey}&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw AppException("Failed to fetch weather data");
    }
  }
}
