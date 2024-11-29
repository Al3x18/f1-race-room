import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:race_room/model/constructor_standings_model.dart';
import 'package:race_room/model/driver_laps_model.dart';
import 'package:race_room/model/driver_standings_model.dart';
import 'package:race_room/model/race_results_model.dart';
import 'package:race_room/model/race_schedule_model.dart';
import 'package:race_room/model/weather_model.dart';
import 'package:race_room/utils/not_share.dart';

class ApiService {
  final Logger _logger = Logger();

  Future<MRDataDriverStandings?> fetchDriverStandings({required String seasonYear}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/driverstandings/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for special characters like accents (ex. Pérez)
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return MRDataDriverStandings.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<MRDataConstructorStandings?> fetchConstructorStandings({required String seasonYear}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/constructorstandings/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return MRDataConstructorStandings.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<MRDataRaceSchedule?> fetchRaceSchedule({required String seasonYear}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/races/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for special characters like accents (ex. Pérez)
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return MRDataRaceSchedule.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<MRDataRaceResults?> fetchRaceResults({required String seasonYear, required String round}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/$round/results/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for special characters like accents (ex. Pérez)
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return MRDataRaceResults.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<MRDataDriverStandings?> fetchDriverStandingsToRound({required String seasonYear, required round}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/$round/driverstandings/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for special characters like accents (ex. Pérez)
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return MRDataDriverStandings.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<MRDataConstructorStandings?> fetchConstructorStandingsToRound({required String seasonYear, required round}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/$round/constructorstandings/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for special characters like accents (ex. Pérez)
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return MRDataConstructorStandings.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<MRDataDriverLaps?> fetchDriverLaps({required String seasonYear, required String round, required String driverId}) async {
    String apiUrl = 'https://api.jolpi.ca/ergast/f1/$seasonYear/$round/drivers/$driverId/laps/?format=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for special characters like accents (ex. Pérez)
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        return MRDataDriverLaps.fromJson(jsonResponse['MRData']);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  Future<WeatherData?> fetchTrackWeather({required String circuitLat, required String circuitLng}) async {
    String apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=$circuitLat&lon=$circuitLng&appid=$OPEN_WEATHER_API_KEY&units=metric";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        return WeatherData.fromJson(jsonResponse);
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('API Call error: $e');
      return null;
    }
  }

  String getWeatherIconUrl(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@2x.png";
  }

  Future<Map<String, dynamic>> checkTelemetryServerStatus() async {
    String apiUrl = "http://$TELEMETRY_SERVER_PUBLIC_IP:$TELEMETRY_SERVER_PORT/status";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      _logger.w('API Call error: ${response.statusCode}');
      return {'status': 'Unreachable'};
    }
  }

 Future<Uint8List> fetchTelemetryPdfFile(String year, String trackName, String session, String driverName) async {
    String apiUrl = "http://$TELEMETRY_SERVER_PUBLIC_IP:$TELEMETRY_SERVER_PORT/get-telemetry?year=$year&trackName=$trackName&session=$session&driverName=$driverName";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        _logger.w('API Call error: ${response.statusCode}');
        final errorMessage = _parseErrorMessage(response.body);
        throw Exception(errorMessage);
      }
    } catch (e) {
      _logger.e('Error: $e');
      throw Exception(e);
    }
  }

  String _parseErrorMessage(String responseBody) {
    try {
      final Map<String, dynamic> errorJson = json.decode(responseBody);
      return errorJson['error'] ?? 'Unknown error occurred';
    } catch (e) {
      return 'Failed to parse error message';
    }
  }
}

