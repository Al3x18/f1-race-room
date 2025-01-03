import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/weather_model.dart';
import 'package:race_room/screens/race_results_view.dart';
import 'package:race_room/utils/check_date.dart';
import 'package:race_room/utils/convert_race_time.dart';
import 'package:race_room/utils/get_track_image.dart';
import 'package:widget_zoom/widget_zoom.dart';

class RaceDetailsView extends StatefulWidget {
  final ScrollController scrollController;

  const RaceDetailsView({
    super.key,
    required this.scrollController,
    required this.raceDate,
    required this.raceTime,
    required this.qualifyingDate,
    required this.qualifyingTime,
    required this.fp1Date,
    required this.fp1Time,
    required this.fp2Date,
    required this.fp2Time,
    required this.fp3Date,
    required this.fp3Time,
    required this.sprintDate,
    required this.sprintTime,
    required this.sprintQualifyingDate,
    required this.sprintQualifyingTime,
    required this.trackName,
    required this.seasonYear,
    required this.raceRound,
    required this.raceName,
    required this.circuitLat,
    required this.circuitLng,
  });

  final String raceDate;
  final String raceTime;
  final String qualifyingDate;
  final String qualifyingTime;
  final String fp1Date;
  final String fp1Time;
  final String fp2Date;
  final String fp2Time;
  final String fp3Date;
  final String fp3Time;
  final String sprintDate;
  final String sprintTime;
  final String sprintQualifyingDate;
  final String sprintQualifyingTime;
  final String trackName;
  final String seasonYear;
  final String raceRound;
  final String raceName;
  final String circuitLat;
  final String circuitLng;

  @override
  State<RaceDetailsView> createState() => _RaceDetailsViewState();
}

class _RaceDetailsViewState extends State<RaceDetailsView> {
  late Future<WeatherData?> weatherData;

  @override
  void initState() {
    weatherData = ApiService().fetchTrackWeather(circuitLat: widget.circuitLat, circuitLng: widget.circuitLng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 85,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: Text(
                widget.fp2Date.isEmpty ? "Sprint Weekend".toUpperCase() : "Standard Race Weekend".toUpperCase(),
                style: listTileStyle.copyWith(
                  fontSize: 15.6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildRaceDetailSection("Race Schedule", widget.raceDate, widget.raceTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            if (widget.fp2Date.isEmpty) const SizedBox(height: 12),
            if (widget.sprintQualifyingDate.isNotEmpty)
              _buildRaceDetailSection("Sprint Race", widget.sprintDate, widget.sprintTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            _buildRaceDetailSection("FP1", widget.fp1Date, widget.fp1Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            if (widget.fp2Date.isNotEmpty) _buildRaceDetailSection("FP2", widget.fp2Date, widget.fp2Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            if (widget.fp2Date.isNotEmpty) const SizedBox(height: 12),
            if (widget.fp3Date.isNotEmpty) _buildRaceDetailSection("FP3", widget.fp3Date, widget.fp3Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            if (widget.sprintQualifyingDate.isNotEmpty)
              _buildRaceDetailSection("Sprint Qualifying", widget.sprintQualifyingDate, widget.sprintQualifyingTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            _buildRaceDetailSection("Qualifying Session", widget.qualifyingDate, widget.qualifyingTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            const Divider(thickness: 1, indent: 14, endIndent: 14, color: Colors.white),
            const SizedBox(height: 12),
            Center(
              child: Text(
                "TRACK MAP",
                style: listTileStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decorationColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Center(
              child: WidgetZoom(
                heroAnimationTag: "circuit",
                zoomWidget: getTrackImage(widget.trackName),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1, indent: 14, endIndent: 14, color: Colors.white),
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: [
                  Text(
                    "CURRENT TRACK WEATHER",
                    style: listTileStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "by Open Weather",
                    style: listTileStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            _buildWeatherSection(listTileStyle),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  FutureBuilder<WeatherData?> _buildWeatherSection(TextStyle listTileStyle) {
    return FutureBuilder(
      future: weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No data available'));
        }

        final String icon = snapshot.data!.weather[0].icon;
        final String description = snapshot.data!.weather[0].description;
        final double temperature = snapshot.data!.main.temp;
        final double feelsLike = snapshot.data!.main.feelsLike;
        final int humidity = snapshot.data!.main.humidity;
        final double windSpeed = snapshot.data!.wind.speed;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.network(ApiService().getWeatherIconUrl(icon), width: 110),
                    Text(description.toUpperCase(), style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TEMPERATURE", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                      Text("$temperature°C", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("FEELS LIKE", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                      Text("$feelsLike°C", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("HUMIDITY", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                      Text("$humidity%", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("WIND", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                      Text("$windSpeed m/s", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    Text("ATMOSPHERIC PRESSURE", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    Text("${snapshot.data!.main.pressure} hPa", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildRaceDetailSection(String title, String date, String time, TextStyle style, String seasonYear, String raceRound, String raceName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.isDarkMode ? Colors.black : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DATE",
                style: style.copyWith(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              Text(
                "${getDayName(date).toUpperCase()}, ${convertDateToLocal(date)}",
                style: style.copyWith(fontSize: 12.5),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "START",
                style: style.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                convertTimeToLocal(date, time),
                style: style.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (title == "Race Schedule") const SizedBox(height: 8),
          Visibility(
            visible: title == "Race Schedule",
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: OutlinedButton(
                onPressed: () {
                  if (isDatePast(date)) {
                    Get.to(
                      () => RaceResultsView(
                        seasonYear: seasonYear,
                        raceRound: raceRound,
                        raceName: raceName,
                      ),
                    );
                  } else {
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      "Results not available",
                      "Try again later.",
                      colorText: Get.isDarkMode ? Colors.black : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Get.isDarkMode ? Colors.white : const Color.fromARGB(255, 30, 30, 30),
                      borderRadius: 6,
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Get.isDarkMode ? Colors.white : Colors.red,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
                ),
                child: Text(
                  "VIEW RESULTS",
                  style: style.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.2,
                    color: Get.isDarkMode ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
