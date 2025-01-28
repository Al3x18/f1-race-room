import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/weather_model.dart';
import 'package:race_room/screens/race_results/race_results_view.dart';
import 'package:race_room/utils/colors/app_colors.dart';
import 'package:race_room/utils/date/check_date.dart';
import 'package:race_room/utils/date/convert_race_time.dart';
import 'package:race_room/utils/track/get_track_image.dart';
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

    // ClipRRect is used to round the corners of the content to match the corners of the sheet when user scroll the content up
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 8),
                  width: 85,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: AppColors.raceDetailsScrollIndicatorTop,
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.fp1Date.isNotEmpty
                      ? widget.fp2Date.isEmpty
                          ? "Sprint Weekend".toUpperCase()
                          : "Standard Race Weekend".toUpperCase()
                      : "Race Weekend Details".toUpperCase(),
                  style: listTileStyle.copyWith(
                    fontSize: 15.6,
                    fontWeight: FontWeight.bold,
                    color: AppColors.raceDetailsTitleText,
                  ),
                ),
              ),
              _buildRaceDetailSection("Race Schedule", widget.raceDate, widget.raceTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              if (widget.sprintQualifyingDate.isNotEmpty) _buildRaceDetailSection("Sprint Race", widget.sprintDate, widget.sprintTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              if (widget.fp1Date.isNotEmpty) _buildRaceDetailSection("FP1", widget.fp1Date, widget.fp1Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              if (widget.fp2Date.isNotEmpty) _buildRaceDetailSection("FP2", widget.fp2Date, widget.fp2Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              if (widget.fp3Date.isNotEmpty) _buildRaceDetailSection("FP3", widget.fp3Date, widget.fp3Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              if (widget.sprintQualifyingDate.isNotEmpty) _buildRaceDetailSection("Sprint Qualifying", widget.sprintQualifyingDate, widget.sprintQualifyingTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              if (widget.qualifyingDate.isNotEmpty) _buildRaceDetailSection("Qualifying Session", widget.qualifyingDate, widget.qualifyingTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
              const Divider(thickness: 1, indent: 14, endIndent: 14, color: AppColors.raceDetailsDivider),
              Center(
                child: Text(
                  "TRACK MAP",
                  style: listTileStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.raceDetailsTrackMapText,
                  ),
                ),
              ),
              Center(
                child: WidgetZoom(
                  heroAnimationTag: "circuit",
                  zoomWidget: getTrackImage(widget.trackName),
                ),
              ),
              const Divider(thickness: 1, indent: 14, endIndent: 14, color: AppColors.raceDetailsDivider),
              Center(
                child: Column(
                  children: [
                    Text(
                      "CURRENT TRACK WEATHER",
                      style: listTileStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.raceDetailsWeatherText,
                      ),
                    ),
                    Text(
                      "by Open Weather",
                      style: listTileStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.raceDetailsWeatherTextSubtitle,
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
              color: AppColors.circularProgressIndicator,
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
                    Image.network(ApiService().getWeatherIconUrl(icon), width: 88),
                    Text(description.toUpperCase(), style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.raceDetailsWeatherText)),
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
                      Text("TEMPERATURE", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                      Text("$temperature°C", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("FEELS LIKE", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                      Text("$feelsLike°C", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
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
                      Text("HUMIDITY", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                      Text("$humidity%", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("WIND", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                      Text("$windSpeed m/s", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Text("ATMOSPHERIC PRESSURE", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
                    Text("${snapshot.data!.main.pressure} hPa", style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.raceDetailsWeatherText)),
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
        color: Get.isDarkMode ? AppColors.raceDetailsSessionContainerDecorationDark : AppColors.raceDetailsSessionContainerDecorationLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.raceDetailsSessionContainerTitleText)),
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
                convertTimeToLocal(date, time) == "No Data" ? "Time currently not available" : convertTimeToLocal(date, time),
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
                      "Try again later",
                      colorText: Get.isDarkMode ? AppColors.raceDetailsSessionResultsSnackTextDark : AppColors.raceDetailsSessionResultsSnackTextLight,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Get.isDarkMode ? AppColors.raceDetailsSessionResultsSnackBackgroundDark : AppColors.raceDetailsSessionResultsSnackBackgroundLight,
                      borderRadius: 6,
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Get.isDarkMode ? AppColors.raceDetailsSessionResultsOutlineButtonBordersDark : AppColors.raceDetailsSessionResultsOutlineButtonBordersLight,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
                ),
                child: Text(
                  "VIEW RESULTS",
                  style: style.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.2,
                    color: Get.isDarkMode ? AppColors.raceDetailsSessionResultsOutlineButtonTextDark : AppColors.raceDetailsSessionResultsOutlineButtonTextLight,
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
